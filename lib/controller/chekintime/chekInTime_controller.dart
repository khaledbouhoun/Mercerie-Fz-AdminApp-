import 'package:admin_ecommerce_app/controller/auth_controller.dart';
import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/data/model/chektime_model.dart';
import 'package:admin_ecommerce_app/data/model/stores_model.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import 'package:geolocator/geolocator.dart' as geo;
import 'package:local_auth/local_auth.dart';

class ChekintimeController extends GetxController {
  final Crud crud = Crud();
  final Dialogfun dialogfun = Dialogfun();
  final AuthController auth = Get.put(AuthController());

  RxList<StoresModel> stores = <StoresModel>[].obs;
  Rx<StoresModel?> nearestStore = Rx<StoresModel?>(null);
  Rx<ChektimeModel?> checkTime = Rx<ChektimeModel?>(null);

  RxBool isAfterStartTime = false.obs;
  RxBool isFingerprintVerified = false.obs;
  RxString statusMessage = ''.obs;
  RxBool isPageLoading = false.obs;
  RxBool isLoading = false.obs;
  Rx<DateTime> checkInTimeDate = DateTime.now().obs;

  // Allowed radius around store (in meters)
  final double allowedDistanceMeters = 100;

  @override
  void onInit() {
    super.onInit();
    print('✅ ChekintimeController initialized');
    fetchsFunction();
  }

  Future<void> fetchsFunction() async {
    isPageLoading.value = true;
    stores = auth.stores;
    await fetchCheckInTime();
    isPageLoading.value = false;
  }

  /// Fetch list of stores from API

  /// Fetch today's check-in time for the current employee
  Future<void> fetchCheckInTime() async {
    try {
      nearestStore.value = null;
      isAfterStartTime.value = false;
      isFingerprintVerified.value = false;
      checkInTimeDate.value = DateTime.now();
      statusMessage.value = '';

      final empId = auth.selectedEmployee?.employeeId;
      if (empId == null) {
        print('❌ Employee not selected');
        return;
      }

      var response = await crud.get('${AppLink.chektime}/$empId');
      if (response.statusCode == 200 && response.body != null) {
        checkTime.value = ChektimeModel.fromJson(response.body);
        checkInTimeDate.value = checkTime.value!.checkInTime!;
        nearestStore.value = stores.firstWhereOrNull((store) => store.storesId == checkTime.value!.chektimeStore);
        isFingerprintVerified.value = true;
      } else {
        checkTime.value = null;
      }
    } catch (e) {
      print('❌ Error fetching check-in time: $e');
      checkTime.value = null;
    }
  }

  /// Save check-in record to server
  Future<void> storeCheckInTime() async {
    if (nearestStore.value == null) {
      dialogfun.showErrorSnack('Error', 'No store selected.');
      return;
    }

    final empId = auth.selectedEmployee?.employeeId;
    if (empId == null) {
      dialogfun.showErrorSnack('Error', 'Employee not found.');
      return;
    }

    final response = await crud.post(AppLink.chektime, {
      'chektime_emp': empId,
      'chektime_store': nearestStore.value!.storesId,
      'check_in_time': checkInTimeDate.value.toIso8601String(),
    });

    if (response.statusCode == 201) {
      dialogfun.showSuccessSnack('Success', 'Check-in recorded successfully.');
      await fetchCheckInTime();
    } else {
      dialogfun.showErrorSnack('Error', 'Failed to record check-in. Please try again.');
    }
  }

  /// Main function to perform check-in
  Future<void> chekInTime() async {
    if (stores.isEmpty) {
      dialogfun.showErrorSnack('Error', 'Store data not available. Please try again later.');
      return;
    }

    isLoading.value = true;
    statusMessage.value = '';

    try {
      // 1️⃣ Check time
      final now = DateTime.now();
      final startTime = DateTime(now.year, now.month, now.day, 8, 30);
      if (now.isBefore(startTime)) {
        statusMessage.value = 'Check-in allowed after 8:30 AM.';
        dialogfun.showErrorSnack('Time Error', statusMessage.value);
        return;
      }

      checkInTimeDate.value = now;

      // 2️⃣ Get GPS position
      final locationData = await getCurrentPosition();
      if (locationData == null) {
        dialogfun.showErrorSnack('Error', 'Failed to get your location.');
        return;
      }

      // 3️⃣ Find nearest store
      final nearest = calculateDistanceFromStore(locationData.latitude!, locationData.longitude!);
      if (nearest == null) {
        statusMessage.value = 'You are not inside any store area.';
        dialogfun.showErrorSnack('Location Error', statusMessage.value);
        return;
      }
      nearestStore.value = nearest;

      // 4️⃣ Biometric verification
      final verified = await authenticateFingerprint();
      if (!verified) {
        statusMessage.value = 'Fingerprint verification failed.';
        dialogfun.showErrorSnack('Error', statusMessage.value);
        return;
      }

      // 5️⃣ All checks passed
      statusMessage.value = '✅ Check-in successful!';
      await storeCheckInTime();
    } catch (e) {
      statusMessage.value = 'Unexpected error: $e';
      dialogfun.showErrorSnack('Error', statusMessage.value);
      print('❌ $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Get and verify GPS location
  Future<loc.LocationData?> getCurrentPosition() async {
    final location = loc.Location();

    // 1️⃣ Ensure GPS service is enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        statusMessage.value = 'Please turn on location service.';
        print('❌ GPS not enabled');
        return null;
      }
    }

    // 2️⃣ Check permissions
    loc.PermissionStatus permission = await location.hasPermission();
    if (permission == loc.PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != loc.PermissionStatus.granted && permission != loc.PermissionStatus.grantedLimited) {
        statusMessage.value = 'Location permission denied.';
        print('❌ Permission denied');
        return null;
      }
    } else if (permission == loc.PermissionStatus.deniedForever) {
      statusMessage.value = 'Location permission permanently denied. Enable it from app settings.';
      print('❌ Permission denied forever');
      return null;
    }

    // 3️⃣ Get location data
    try {
      final locationData = await location.getLocation();
      return locationData;
    } catch (e) {
      statusMessage.value = 'Failed to get location: $e';
      print('❌ $e');
      return null;
    }
  }

  /// Fingerprint / biometric authentication
  Future<bool> authenticateFingerprint() async {
    final LocalAuthentication auth = LocalAuthentication();

    final bool canCheckBiometrics = await auth.canCheckBiometrics;
    final bool isDeviceSupported = await auth.isDeviceSupported();

    if (!canCheckBiometrics && !isDeviceSupported) {
      statusMessage.value = 'Biometric authentication not supported on this device.';
      print(statusMessage.value);
      return false;
    }

    try {
      final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
      final bool allowDeviceCredentials = availableBiometrics.isEmpty;

      final bool didAuthenticate = await auth.authenticate(
        localizedReason:
            allowDeviceCredentials
                ? 'Authenticate with your device password to continue'
                : 'Authenticate with your fingerprint to continue',
        biometricOnly: !allowDeviceCredentials,
      );

      return didAuthenticate;
    } catch (e) {
      statusMessage.value = 'Biometric error: $e';
      print('❌ Biometric error: $e');
      return false;
    }
  }

  /// Calculate nearest store based on GPS distance
  StoresModel? calculateDistanceFromStore(double userLat, double userLng) {
    double minDistance = double.infinity;
    StoresModel? nearest;

    for (var store in stores) {
      final storeLat = store.storesLat ?? 0.0;
      final storeLng = store.storesLong ?? 0.0;
      final distance = geo.Geolocator.distanceBetween(userLat, userLng, storeLat, storeLng);

      if (distance < minDistance) {
        minDistance = distance;
        nearest = store;
      }
    }

    if (minDistance <= allowedDistanceMeters) {
      print('✅ Nearest store: ${nearest?.storesNom}, distance: ${minDistance.toStringAsFixed(1)}m');
      return nearest;
    } else {
      print('❌ No nearby store found. Closest: ${minDistance.toStringAsFixed(1)}m');
      return null;
    }
  }
}
