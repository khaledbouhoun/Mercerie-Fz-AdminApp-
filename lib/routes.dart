import 'package:admin_ecommerce_app/core/constant/routesstr.dart';
import 'package:admin_ecommerce_app/view/aurh.dart';
import 'package:admin_ecommerce_app/view/category/category.dart';
import 'package:admin_ecommerce_app/view/category/categoryadd.dart';
import 'package:admin_ecommerce_app/view/category/categoryupdate.dart';
import 'package:admin_ecommerce_app/view/employe/employe.dart';
import 'package:admin_ecommerce_app/view/employe/employe_add.dart';
import 'package:admin_ecommerce_app/view/homescreen.dart';
import 'package:admin_ecommerce_app/view/items/itemadd.dart';
import 'package:admin_ecommerce_app/view/items/items.dart';
import 'package:admin_ecommerce_app/view/items/itemupdate.dart';
import 'package:admin_ecommerce_app/view/order/cash.dart';
import 'package:admin_ecommerce_app/view/order/completeyallidineorder.dart';
import 'package:admin_ecommerce_app/view/order/historycashorder.dart';
import 'package:admin_ecommerce_app/view/order/order.dart';
import 'package:admin_ecommerce_app/view/order/orderdetails.dart';
import 'package:admin_ecommerce_app/view/order/orderdetailsyallidine.dart';
import 'package:admin_ecommerce_app/view/order/yallidine.dart';
import 'package:admin_ecommerce_app/view/stats/dashboard.dart';
import 'package:admin_ecommerce_app/view/stats/stats.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: () => const AuthScreen()),

  GetPage(name: AppRoute.employe, page: () => EmployeePage()),
  GetPage(name: AppRoute.employeadd, page: () => const EmployeeAdd()),

  GetPage(name: AppRoute.home, page: () => const HomeScreen()),
  GetPage(name: AppRoute.category, page: () => const Category()),
  GetPage(name: AppRoute.categoryadd, page: () => const CategoryAdd()),

  GetPage(name: AppRoute.dashboard, page: () => const Dashboard()),
  GetPage(name: AppRoute.stats, page: () => const Stats()),

  GetPage(name: AppRoute.categoryupdate, page: () => const Categoryupdate()),

  GetPage(name: AppRoute.item, page: () => const Item()),
  GetPage(name: AppRoute.itemadd, page: () => Itemadd()),
  GetPage(name: AppRoute.itemupdate, page: () => const Itemupdate()),

  GetPage(name: AppRoute.order, page: () => Order()),
  GetPage(name: AppRoute.cash, page: () => Cash()),
  GetPage(name: AppRoute.yallidine, page: () => Yallidine()),
  GetPage(name: AppRoute.orderdetails, page: () => const Orderdetails()),
  GetPage(name: AppRoute.orderdetailsyallidine, page: () => const OrderdetailsYallidine()),
  GetPage(name: AppRoute.completeyallidineorder, page: () => const CompleteYallidineOrder()),
  GetPage(name: AppRoute.historycash, page: () => const HistoryCashOrder()),
];
