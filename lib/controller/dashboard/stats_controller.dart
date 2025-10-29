import 'package:admin_ecommerce_app/core/class/statusrequest.dart';
import 'package:admin_ecommerce_app/data/model/dashboard_model.dart';
import 'package:admin_ecommerce_app/data/remote/dashboard_data.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StatsController extends GetxController {
  DashboardData dashboardData = DashboardData(Get.find());

  // Observable variables
  var statusRequest = StatusRequest.none.obs;
  var dashboardSalesData = Rxn<DashboardSalesData>();
  var paymentMethodsData = <PaymentMethodData>[].obs;
  var salesOverTimeData = <SalesOverTimeData>[].obs;
  var selectedPeriod = 'Last 30 Days'.obs;
  var errorMessage = ''.obs;

  // Date range options
  final List<String> periodOptions = ['Today', 'Last 7 Days', 'Last 30 Days'];

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  double interval() {
    switch (salesOverTimeData.length) {
      case < 10:
        return 1;
      case >= 5 && <= 10:
        return 2;
      case >= 10 && <= 20:
        return 4;
      case >= 20 && <= 30:
        return 5;
      default:
        return 6;
    }
  }

  // Load all dashboard data
  Future<void> loadDashboardData() async {
    statusRequest.value = StatusRequest.loading;
    errorMessage.value = '';

    try {
      // Load sales data
      await loadSalesData();

      // Load payment method data
      await loadPaymentMethodData();

      // Load sales over time data
      await loadSalesOverTimeData();

      statusRequest.value = StatusRequest.success;
    } catch (e) {
      statusRequest.value = StatusRequest.serverfailure;
      errorMessage.value = 'Failed to load dashboard data: $e';
    }
  }

  // Load overall sales data
  Future<void> loadSalesData() async {
    var response = await dashboardData.getDashboardSales();
    response.fold(
      (l) {
        statusRequest.value = l;
        errorMessage.value = 'Failed to load sales data';
      },
      (r) {
        if (r.success && r.salesData != null) {
          dashboardSalesData.value = r.salesData;
        } else {
          errorMessage.value = r.message ?? 'Failed to load sales data';
        }
      },
    );
  }

  // Load payment method data
  Future<void> loadPaymentMethodData() async {
    var response = await dashboardData.getSalesByPaymentMethod();
    response.fold(
      (l) {
        statusRequest.value = l;
        errorMessage.value = 'Failed to load payment method data';
      },
      (r) {
        if (r.success && r.paymentMethods != null) {
          paymentMethodsData.value = r.paymentMethods!;
        } else {
          errorMessage.value = r.message ?? 'Failed to load payment method data';
        }
      },
    );
  }

  // Load sales over time data
  Future<void> loadSalesOverTimeData() async {
    String? startDate;
    String? endDate;

    // Calculate date range based on selected period
    final now = DateTime.now();
    switch (selectedPeriod.value) {
      case 'Today':
        startDate = DateFormat('yyyy-MM-dd').format(now);
        endDate = startDate;
        break;
      case 'Last 7 Days':
        startDate = DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 6)));
        endDate = DateFormat('yyyy-MM-dd').format(now);
        break;
      case 'Last 30 Days':
        startDate = DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 29)));
        endDate = DateFormat('yyyy-MM-dd').format(now);
        break;
    }

    var response = await dashboardData.getSalesOverTime(startDate: startDate, endDate: endDate);

    response.fold(
      (l) {
        statusRequest.value = l;
        errorMessage.value = 'Failed to load sales over time data';
      },
      (r) {
        if (r.success && r.salesOverTime != null) {
          salesOverTimeData.value = r.salesOverTime!;

          update();
        } else {
          errorMessage.value = r.message ?? 'Failed to load sales over time data';
        }
      },
    );
  }

  // Change period and reload sales over time data
  void changePeriod(String period) {
    selectedPeriod.value = period;
    loadSalesOverTimeData();
  }

  // Refresh all data
  Future<void> refreshData() async {
    await loadDashboardData();
  }

  // Format currency
  String Function(dynamic) formatCurrency = (dynamic amount) {
    return NumberFormat.currency(symbol: '\$').format((amount as num).toDouble());
  };

  // Format number with commas
  String Function(dynamic) formatNumber = (dynamic number) {
    return NumberFormat('#,###').format((number as num).toInt());
  };
}
