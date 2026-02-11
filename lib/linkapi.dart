class AppLink {
  

  // static const server = "http://10.113.254.220:8000/api";
  static const server = "https://merceriefz.com/mercerie_api";
  static const adminapp = "$server/api";
  static const String categoryImagesFolder = "catg_images";
  static const String itemImagesFolder = "item_images";
  static const String categoryImagesPath = "$server/mercerie/catg_images/";
  static const String itemImagesPath = "$server/mercerie/item_images/";
  // Image
  static const String imageupload = "$adminapp/image/upload";
  static const String imagedelete = "$adminapp/image/delete";
  static const String imageupdate = "$adminapp/image/update";

  // employee
  static const String employees = "$adminapp/employees";
  static const String employeesLogin = "$adminapp/employees/login";
  static const String employeesToggleStatus = "$adminapp/employees/togglestatus";

  // Category
  static const String categories = "$adminapp/categories";

  // Item
  static const String items = "$adminapp/items";
  static const String itemsColor = "$adminapp/items/colors";
  static const String itemsToggleStatus = "$adminapp/items/togglestatus";

  // Unite
  static const String unites = "$adminapp/unites";

  // Yallidine
  static const String yallidine = "$adminapp/yallidine";
  static const String yallidineDetails = "$adminapp/yallidine/details";
  static const String yallidineStatus = "$adminapp/yallidine/status";
  static const String yallidineRelease = "$adminapp/yallidine/release";
  static const String yallidineKeepAlive = "$adminapp/yallidine/keepalive";
  static const String yallidineConfirm = "$adminapp/yallidine/confirm";

  // chektime
  static const String chektime = "$adminapp/chektime";
  static const String stores = "$adminapp/chektime/stores";

  //========================== Auth ============================

  static const String authenticate = "$adminapp/auth/authenticate.php";
  static const String getemployes = "$adminapp/auth/getemployes.php";

  //========================== Employee ============================
  static const String empgetall = "$adminapp/employee/emp_getall.php";
  static const String empadd = "$adminapp/employee/emp_add.php";
  static const String empupdate = "$adminapp/employee/emp_update.php";
  static const String empdelete = "$adminapp/employee/emp_delete.php";
  static const String empToggleStatus = "$adminapp/employee/empToggleStatus.php";

  //========================== Category ============================

  static const String catggetall = "$adminapp/category/catg_getall.php";
  static const String catadd = "$adminapp/category/catg_add.php";
  static const String catupdate = "$adminapp/category/catg_update.php";
  static const String catdelete = "$adminapp/category/catg_delete.php";
  static const String catgimage = "$adminapp/category/catg_image.php";
  static const String catgdeleteimage = "$adminapp/category/catg_delete_image.php";

  //========================== Item ============================
  static const String itemgetall = "$adminapp/items/item_getall.php";
  static const String itemadd = "$adminapp/items/item_add.php";
  static const String itemupdate = "$adminapp/items/item_update.php";
  static const String itemgetcolor = "$adminapp/items/item_getcolor.php";
  static const String itemdelete = "$adminapp/items/item_delete.php";
  static const String itemimage = "$adminapp/items/item_image.php";
  static const String itemdeleteimage = "$adminapp/items/Image_delete.php";
  static const String itemtogglestatus = "$adminapp/items/item_status.php";

  //========================== Order ============================

  static const String keepalive = "$adminapp/order/keep_alive.php";
  static const String releaseOrder = "$adminapp/order/realese_order.php";
  static const String deleteItemCart = "$adminapp/order/delete_item_cart.php";

  //=============== Cash =================
  static const String cashgetall = "$adminapp/cash/cash_getall.php";
  static const String confirmCashOrder = "$adminapp/cash/cash_confirmorder.php";
  static const String cashCart = "$adminapp/cash/cash_cart.php";
  static const String cashCartColor = "$adminapp/cash/cash_cartcolor.php";

  //=============== Yallidine =================
  static const String yallidinegetall = "$adminapp/yallidine/yallidine_getall.php";
  static const String yallidineCart = "$adminapp/yallidine/yallidine_cart.php";
  static const String yallidineCartColor = "$adminapp/yallidine/yallidine_cartcolor.php";
  static const String confirmYallidineOrder = "$adminapp/yallidine/yallidine_confirmorder.php";
  static const String yallidineCompletedOrders = "$adminapp/yallidine/yallidine_completedorders.php";
  //=============== Dashboard =================
  static const String dashboardSales = "$adminapp/api/dashboard_sales.php";
  static const String salesByPaymentMethod = "$adminapp/api/sales_by_payment_method.php";
  static const String salesOverTime = "$adminapp/api/sales_over_time.php";
}
