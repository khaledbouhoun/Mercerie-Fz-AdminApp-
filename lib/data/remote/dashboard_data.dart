import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/core/class/statusrequest.dart';
import 'package:admin_ecommerce_app/data/model/dashboard_model.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:dartz/dartz.dart';

class DashboardData {
  Crud crud;

  DashboardData(this.crud);

  // Fetch overall sales data
  Future<Either<StatusRequest, DashboardResponse>> getDashboardSales() async {
    var response = await crud.getData(AppLink.dashboardSales, "");
    return response.fold((l) => Left(l), (r) => Right(DashboardResponse.fromJson(Map<String, dynamic>.from(r))));
  }

  // Fetch sales by payment method
  Future<Either<StatusRequest, DashboardResponse>> getSalesByPaymentMethod() async {
    var response = await crud.getData(AppLink.salesByPaymentMethod, "");
    return response.fold((l) => Left(l), (r) => Right(DashboardResponse.fromJson(Map<String, dynamic>.from(r))));
  }

  // Fetch sales over time with optional date range
  Future<Either<StatusRequest, DashboardResponse>> getSalesOverTime({String? startDate, String? endDate}) async {
    String url = AppLink.salesOverTime;

    if (startDate != null && endDate != null) {
      url += "?start_date=$startDate&end_date=$endDate";
    }

    var response = await crud.getData(url, "");
    return response.fold((l) => Left(l), (r) => Right(DashboardResponse.fromJson(Map<String, dynamic>.from(r))));
  }
}
