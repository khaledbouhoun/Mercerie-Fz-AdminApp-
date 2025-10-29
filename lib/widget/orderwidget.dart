import 'package:admin_ecommerce_app/controller/order/cash_controller.dart';
import 'package:admin_ecommerce_app/controller/order/yallidine_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/routesstr.dart';
import 'package:admin_ecommerce_app/data/model/cart_model.dart';
import 'package:admin_ecommerce_app/data/model/cash_model.dart';
import 'package:admin_ecommerce_app/data/model/yallidne_model.dart';
import 'package:admin_ecommerce_app/data/model/yallidine_complete_model.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Orderwidget extends StatelessWidget {
  final CashModel cashmodel;
  final CashController controller;
  final bool completed;
  final bool history;

  const Orderwidget({super.key, required this.cashmodel, required this.completed, required this.controller, this.history = false});

  @override
  Widget build(BuildContext context) {
    final Color accentColor = cashmodel.shop == 1 ? AppColor.bachdjerrah : AppColor.belcourt;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: accentColor.withOpacity(0.08), spreadRadius: 12, blurRadius: 12, offset: const Offset(1, 6))],
        border: Border.all(color: accentColor, width: 2),
      ),
      child: ExpandableNotifier(
        child: Column(
          children: [
            // Header
            Column(
              children: [
                // O
                //Rrder ID and Employee
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.receipt_long, color: accentColor, size: 20),
                        const SizedBox(width: 8),
                        Text('#${cashmodel.ordersId}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: accentColor)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: completed ? Colors.green.withOpacity(0.1) : accentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: completed ? Colors.green : accentColor, width: 1),
                      ),
                      child: Row(
                        children: [
                          Icon(completed ? Icons.check_circle : Icons.timelapse, color: completed ? Colors.green : accentColor, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            completed ? 'Completed' : 'Pending',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: completed ? Colors.green : accentColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Status Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.grey[400], size: 16),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('dd/MM/yyyy - HH:mm').format(cashmodel.ordersDatetime!),
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    // Action Button
                    ElevatedButton(
                      onPressed: () async {
                        if (completed) {
                          // await controller.view(cashmodel.ordersId!.toString());
                          controller.cashselcted = cashmodel;
                          controller.cashcompleted = completed;
                          Get.toNamed(
                            AppRoute.orderdetails,
                            arguments: {
                              "history": history,
                              "idemp": controller.idemp,
                              "cashselcted": controller.cashselcted,
                              "carts": controller.carts,
                              "cashcompleted": controller.cashcompleted,
                            },
                          );
                        } else {
                          await controller.view(cashmodel.ordersId!.toString(), cashmodel.employeename!);
                          if (controller.go) {
                            controller.cashselcted = cashmodel;
                            controller.cashcompleted = completed;
                            Get.toNamed(
                              AppRoute.orderdetails,
                              arguments: {
                                'idemp': controller.idemp,
                                'cashselcted': controller.cashselcted,
                                'carts': controller.carts,
                                'cashcompleted': controller.cashcompleted,
                              },
                            );
                            controller.go = false;
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: completed ? Colors.green : accentColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        elevation: 0,
                      ),
                      child: Text(completed ? 'View' : 'Take', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),

            // Expandable Details
            ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToCollapse: true,
                tapBodyToExpand: true,
                hasIcon: true,
              ),
              header: const SizedBox.shrink(),
              collapsed: const SizedBox.shrink(),
              expanded: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    const SizedBox(height: 8),
                    _buildDetailRow(Icons.person, 'Customer', cashmodel.usersName ?? '-'),
                    const SizedBox(height: 8),
                    _buildDetailRow(Icons.shopping_bag, 'Items', cashmodel.items?.toString() ?? '-'),
                    const SizedBox(height: 8),
                    _buildDetailRow(
                      Icons.attach_money,
                      'Total',
                      '${cashmodel.ordersTotalprice?.toStringAsFixed(2) ?? '0.00'} DA',
                      bold: true,
                    ),
                    _buildDetailRow(Icons.person, 'Preparator', cashmodel.employeename ?? '-'),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {bool bold = false}) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 8),
        Text('$label:', style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 4),
        Expanded(child: Text(value, style: TextStyle(color: Colors.black87, fontWeight: bold ? FontWeight.bold : FontWeight.normal))),
      ],
    );
  }
}

class OrderwidgetYallidine extends StatelessWidget {
  final YallidineModel yallidineModel;
  final YallidineController controller;
  final bool completed;

  const OrderwidgetYallidine({super.key, required this.yallidineModel, required this.completed, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: AppColor.yallidineColor.withOpacity(0.08), spreadRadius: 2, blurRadius: 12, offset: const Offset(0, 6)),
          ],
          border: Border.all(color: AppColor.yallidineColor, width: 2),
        ),
        child: ExpandableNotifier(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    // Order ID and Employee
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.receipt_long, color: AppColor.yallidineColor, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                yallidineModel.employeeName!.isEmpty
                                    ? '#${yallidineModel.yId}'
                                    : '#${yallidineModel.yId} by ${yallidineModel.employeeName}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.yallidineColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.access_time, color: Colors.grey[400], size: 16),
                              const SizedBox(width: 4),
                              Text(
                                DateFormat('dd/MM/yyyy - HH:mm').format(yallidineModel.yDatetime!),
                                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: completed ? Colors.green.withOpacity(0.1) : AppColor.yallidineColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: completed ? Colors.green : AppColor.yallidineColor, width: 1),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            completed ? Icons.check_circle : Icons.timelapse,
                            color: completed ? Colors.green : AppColor.yallidineColor,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            completed ? 'Completed' : 'Pending',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: completed ? Colors.green : AppColor.yallidineColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Action Button
                    ElevatedButton(
                      onPressed: () async {
                        if (completed) {
                          List<CartModel> carts = await controller.view(yallidineModel, yallidineModel.employeeName!, 0);
                          if (carts.isNotEmpty) {
                            Get.toNamed(
                              AppRoute.orderdetailsyallidine,
                              arguments: {
                                "idemp": controller.idemp,
                                "yallidineselcted": yallidineModel,
                                "carts": carts,
                                "yallidinecompleted": completed,
                              },
                            );
                          }
                        } else {
                          List<CartModel> carts = await controller.view(yallidineModel, yallidineModel.employeeName!, 1);
                          if (carts.isNotEmpty) {
                            Get.toNamed(
                              AppRoute.orderdetailsyallidine,
                              arguments: {
                                "idemp": controller.idemp,
                                "yallidineselcted": yallidineModel,
                                "carts": carts,
                                "yallidinecompleted": completed,
                              },
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: completed ? Colors.green : AppColor.yallidineColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        elevation: 0,
                      ),
                      child: Obx(
                        () =>
                            yallidineModel.isLoading!.value
                                ? Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                : Text(
                                  completed ? 'View' : 'Take',
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              // Expandable Details
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                  tapBodyToExpand: true,
                  hasIcon: true,
                ),
                header: const SizedBox.shrink(),
                collapsed: const SizedBox.shrink(),
                expanded: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      const SizedBox(height: 8),
                      _buildDetailRow(Icons.person, 'Customer', '${yallidineModel.yPrenome ?? ''} ${yallidineModel.yName ?? ''}'),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        Icons.location_on,
                        'Address',
                        '${yallidineModel.yWilaya}, ${yallidineModel.yComunue}, ${yallidineModel.yAgenceAdresse}',
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(Icons.shopping_bag, 'Items', yallidineModel.items?.toString() ?? '-'),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        Icons.attach_money,
                        'Total',
                        '${yallidineModel.yTotalprice?.toStringAsFixed(2) ?? '0.00'} DA',
                        bold: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {bool bold = false}) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 8),
        Text('$label:', style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 4),
        Expanded(child: Text(value, style: TextStyle(color: Colors.black87, fontWeight: bold ? FontWeight.bold : FontWeight.normal))),
      ],
    );
  }
}

class OrderwidgetYallidineHistory extends StatelessWidget {
  final YallidineCompleteData yallidineCompleteData;
  final YallidineController controller;
  final bool completed;

  const OrderwidgetYallidineHistory({super.key, required this.yallidineCompleteData, required this.completed, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(18),
        shadowColor: AppColor.yallidineColor.withOpacity(0.13),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColor.yallidineColor, width: 2),
          ),
          child: ExpandableNotifier(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.local_shipping, color: AppColor.yallidineColor, size: 22),
                              const SizedBox(width: 8),
                              Text(
                                '#${yallidineCompleteData.tracking}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.yallidineColor),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.download, color: AppColor.yallidineColor, size: 22),
                            onPressed: () async {
                              await launchUrl(Uri.parse(yallidineCompleteData.label ?? ''));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.grey[400], size: 15),
                          const SizedBox(width: 4),
                          Text(yallidineCompleteData.dateCreation ?? 'No date', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                ),
                // Expandable Details
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                    tapBodyToExpand: true,
                    hasIcon: true,
                  ),
                  header: const SizedBox.shrink(),
                  collapsed: const SizedBox.shrink(),
                  expanded: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.person, 'Customer', '${yallidineCompleteData.firstname} ${yallidineCompleteData.familyname}'),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.phone, 'Phone', yallidineCompleteData.contactPhone ?? '-'),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.shopping_bag, 'Product', yallidineCompleteData.productList ?? '-'),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          Icons.attach_money,
                          'Price',
                          '${yallidineCompleteData.price?.toStringAsFixed(2) ?? '0.00'} DA',
                          bold: true,
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.location_on, 'From', yallidineCompleteData.fromWilayaName ?? '-'),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          Icons.location_city,
                          'To',
                          '${yallidineCompleteData.toWilayaName ?? '-'}, ${yallidineCompleteData.toCommuneName ?? '-'}',
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.local_shipping, 'Current Center', yallidineCompleteData.currentCenterName ?? '-'),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.info, 'Status', yallidineCompleteData.lastStatus ?? '-'),
                        if (yallidineCompleteData.deliveryFee != null && yallidineCompleteData.deliveryFee! > 0) ...[
                          const SizedBox(height: 8),
                          _buildDetailRow(Icons.delivery_dining, 'Delivery Fee', '${yallidineCompleteData.deliveryFee} DA'),
                        ],
                        if (yallidineCompleteData.weight != null) ...[
                          const SizedBox(height: 8),
                          _buildDetailRow(Icons.scale, 'Weight', '${yallidineCompleteData.weight} kg'),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {bool bold = false}) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 8),
        Text('$label:', style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 4),
        Expanded(child: Text(value, style: TextStyle(color: Colors.black87, fontWeight: bold ? FontWeight.bold : FontWeight.normal))),
      ],
    );
  }
}
