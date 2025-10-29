class DashboardSalesData {
  final double totalSales;
  final int totalOrders;
  final double averageOrderValue;

  DashboardSalesData({required this.totalSales, required this.totalOrders, required this.averageOrderValue});

  factory DashboardSalesData.fromJson(Map<String, dynamic> json) {
    return DashboardSalesData(
      totalSales: (json['total_sales'] ?? 0).toDouble(),
      totalOrders: json['total_orders'] ?? 0,
      averageOrderValue: (json['average_order_value'] ?? 0).toDouble(),
    );
  }
}

class PaymentMethodData {
  final String method;
  final double amount;
  final double percentage;

  PaymentMethodData({required this.method, required this.amount, required this.percentage});

  factory PaymentMethodData.fromJson(Map<String, dynamic> json) {
    return PaymentMethodData(
      method: json['method'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      percentage: (json['percentage'] ?? 0).toDouble(),
    );
  }
}

class SalesOverTimeData {
  final String date;
  final double amount;

  SalesOverTimeData({required this.date, required this.amount});

  factory SalesOverTimeData.fromJson(Map<String, dynamic> json) {
    return SalesOverTimeData(date: json['date'] ?? '', amount: (json['amount'] ?? 0).toDouble());
  }
}

class DashboardResponse {
  final bool success;
  final String? message;
  final DashboardSalesData? salesData;
  final List<PaymentMethodData>? paymentMethods;
  final List<SalesOverTimeData>? salesOverTime;

  DashboardResponse({required this.success, this.message, this.salesData, this.paymentMethods, this.salesOverTime});

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      success: json['success'] ?? false,
      message: json['message'],
      salesData: json['sales_data'] != null ? DashboardSalesData.fromJson(json['sales_data']) : null,
      paymentMethods:
          json['payment_methods'] != null
              ? List<PaymentMethodData>.from(json['payment_methods'].map((x) => PaymentMethodData.fromJson(x)))
              : null,
      salesOverTime:
          json['sales_over_time'] != null
              ? List<SalesOverTimeData>.from(json['sales_over_time'].map((x) => SalesOverTimeData.fromJson(x)))
              : null,
    );
  }
}
