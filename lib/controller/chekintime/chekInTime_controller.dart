import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import 'package:local_auth/local_auth.dart';
import 'dart:math';

class ChekintimeController extends GetxController {
  Crud crud = Crud();
  Dialogfun dialogfun = Dialogfun();

  RxBool isAtStore = false.obs;
  RxBool isAfterStartTime = false.obs;
  RxBool isFingerprintVerified = false.obs;
  RxString statusMessage = ''.obs;
  RxBool isLoading = false.obs;

  // Store location (example coordinates)
  final double storeLat = 36.742094;
  final double storeLng = 3.176871;
  final double allowedDistanceMeters = 100; // 100m radius around store

  @override
  void onInit() {
    super.onInit();
    print('✅ ChekintimeController initialized');
  }

  Future<void> chekInTime() async {
    isLoading.value = true;
    isAtStore.value = false;
    isAfterStartTime.value = false;
    isFingerprintVerified.value = false;
    statusMessage.value = '';

    try {
      // 1️⃣ Check time
      final now = DateTime.now();
      final startTime = DateTime(now.year, now.month, now.day, 8, 30);
      isAfterStartTime.value = now.isAfter(startTime);
      if (!isAfterStartTime.value) {
        statusMessage.value = 'Check-in allowed after 8:30 AM.';
        return;
      }

      // 2️⃣ Check location permissions and distance
      final locationData = await getCurrentPosition();
      if (locationData == null) {
        statusMessage.value = 'Location data is null.';
        return;
      }

      final distance = _calculateDistance(locationData.latitude ?? 0, locationData.longitude ?? 0, storeLat, storeLng);
      isAtStore.value = distance <= allowedDistanceMeters;
      if (!isAtStore.value) {
        statusMessage.value = 'You are not at the store location (distance: ${distance.toStringAsFixed(1)} m).';
        return;
      }

      // 3️⃣ Fingerprint verification
      final verified = await authenticateFingerprint();
      isFingerprintVerified.value = verified;
      if (!verified) {
        statusMessage.value = 'Fingerprint verification failed.';
        return;
      }

      // 4️⃣ All checks passed
      statusMessage.value = '✅ Check-in successful!';
      // TODO: Save check-in record to backend using your CRUD class
    } catch (e) {
      statusMessage.value = 'Unexpected error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Get and verify GPS position
  Future<loc.LocationData?> getCurrentPosition() async {
    final location = loc.Location();

    // 1️⃣ Check if location service (GPS) is ON
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService(); // 💡 shows system popup
      if (!serviceEnabled) {
        statusMessage.value = 'Location service is disabled.';
        print('❌ User refused to enable location service.');
        return null;
      }
    }

    // 2️⃣ Check permission
    loc.PermissionStatus permission = await location.hasPermission();
    if (permission == loc.PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != loc.PermissionStatus.granted) {
        statusMessage.value = 'Location permission denied.';
        print('❌ Location permission denied.');
        return null;
      }
    }

    if (permission == loc.PermissionStatus.deniedForever) {
      statusMessage.value = 'Location permission permanently denied.';
      print('❌ Location permission permanently denied.');
      return null;
    }

    // 3️⃣ Get current location
    return await location.getLocation();
  }

  /// Perform biometric authentication
  Future<bool> authenticateFingerprint() async {
    final LocalAuthentication auth = LocalAuthentication();
    // ···
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    if (!canAuthenticate) {
      statusMessage.value = 'Biometric authentication not supported on this device.';
      print('Biometric authentication not supported on this device.');
      return false;
    }

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        biometricOnly: true,
      );
      return didAuthenticate;
    } catch (e) {
      statusMessage.value = 'Biometric error: $e';
      print('Biometric error: $e');
      return false;
    }
  }

  /// Calculate distance using Haversine formula
  double _calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    const double R = 6371000; // meters
    final dLat = _deg2rad(lat2 - lat1);
    final dLng = _deg2rad(lng2 - lng1);
    final a = sin(dLat / 2) * sin(dLat / 2) + cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) * sin(dLng / 2) * sin(dLng / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _deg2rad(double deg) => deg * pi / 180.0;
}
