import 'package:admin_ecommerce_app/controller/dashboard/stats_controller.dart';

import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StatsController());
    return Scaffold(
      backgroundColor: AppColor.background,

      body: GetBuilder<StatsController>(
        builder:
            (controller) => RefreshIndicator(
              onRefresh: () async => await controller.refreshData(),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Error message
                      if (controller.errorMessage.value.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.red.shade600),
                              const SizedBox(width: 12),
                              Expanded(child: Text(controller.errorMessage.value, style: TextStyle(color: Colors.red.shade700))),
                            ],
                          ),
                        ),

                      // Key Metrics Cards
                      _buildMetricsSection(controller),

                      const SizedBox(height: 24),

                      // Sales by Payment Method Chart
                      _buildPaymentMethodChart(controller),

                      const SizedBox(height: 24),

                      // Sales Over Time Chart
                      _buildSalesOverTimeChart(controller),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }

  Widget _buildMetricsSection(StatsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Key Metrics', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              // Desktop/Tablet layout
              return Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      'Total Sales',
                      controller.dashboardSalesData.value?.totalSales ?? 0,
                      controller.formatCurrency,
                      Icons.attach_money,
                      Colors.green,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildMetricCard(
                      'Total Orders',
                      controller.dashboardSalesData.value?.totalOrders ?? 0,
                      controller.formatNumber,
                      Icons.shopping_cart,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildMetricCard(
                      'Average Order Value',
                      controller.dashboardSalesData.value?.averageOrderValue ?? 0,
                      controller.formatCurrency,
                      Icons.analytics,
                      Colors.orange,
                    ),
                  ),
                ],
              );
            } else {
              // Mobile layout
              return Column(
                children: [
                  _buildMetricCard(
                    'Total Sales',
                    controller.dashboardSalesData.value?.totalSales ?? 0,
                    controller.formatCurrency,
                    Icons.attach_money,
                    Colors.green,
                  ),
                  const SizedBox(height: 16),
                  _buildMetricCard(
                    'Total Orders',
                    controller.dashboardSalesData.value?.totalOrders ?? 0,
                    controller.formatNumber,
                    Icons.shopping_cart,
                    Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  _buildMetricCard(
                    'Average Order Value',
                    controller.dashboardSalesData.value?.averageOrderValue ?? 0,
                    controller.formatCurrency,
                    Icons.analytics,
                    Colors.orange,
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, dynamic value, String Function(dynamic) formatter, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: color, size: 24),
              ),
              const Spacer(),
              Icon(Icons.trending_up, color: Colors.green, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(formatter(value), style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodChart(StatsController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sales by Payment Method', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 24),
          if (controller.paymentMethodsData.isEmpty)
            const Center(child: Text('No payment method data available', style: TextStyle(color: Colors.grey)))
          else
            SizedBox(
              height: 300,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: PieChart(PieChartData(sections: _buildPieChartSections(controller), centerSpaceRadius: 40, sectionsSpace: 2)),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildPieChartLegend(controller),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(StatsController controller) {
    final colors = [AppColor.primaryColor, AppColor.yallidineColor];

    return controller.paymentMethodsData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      return PieChartSectionData(
        color: colors[index],
        value: data.amount,
        title: '${data.percentage.toStringAsFixed(1)}%',
        radius: 80,
        titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();
  }

  List<Widget> _buildPieChartLegend(StatsController controller) {
    final colors = [AppColor.primaryColor, AppColor.yallidineColor];
    return controller.paymentMethodsData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(width: 16, height: 16, decoration: BoxDecoration(color: colors[index], shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.method, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Text(controller.formatCurrency(data.amount), style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildSalesOverTimeChart(StatsController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Sales Over Time', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
              _buildPeriodSelector(controller),
            ],
          ),
          const SizedBox(height: 24),
          if (controller.salesOverTimeData.isEmpty)
            const Center(child: Text('No sales data available for the selected period', style: TextStyle(color: Colors.grey)))
          else
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    drawHorizontalLine: false,
                    drawVerticalLine: false,
                    show: true,

                    horizontalInterval: 1,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: controller.interval().toDouble(),
                        getTitlesWidget: (double value, TitleMeta meta) {
                          if (value.toInt() >= 0 && value.toInt() < controller.salesOverTimeData.length) {
                            final date = controller.salesOverTimeData[value.toInt()].date;
                            return SideTitleWidget(
                              // meta: meta,
                              axisSide: meta.axisSide,
                              child: Text(
                                DateFormat('MM/dd').format(DateTime.parse(date)),
                                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1500,

                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            controller.formatCurrency(value),
                            style: const TextStyle(color: Color.fromARGB(255, 169, 29, 29), fontWeight: FontWeight.bold, fontSize: 12),
                          );
                        },
                        reservedSize: 70,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.shade300)),
                  minX: 0,
                  maxX: (controller.salesOverTimeData.length - 1).toDouble(),
                  minY: 0,
                  maxY:
                      controller.salesOverTimeData.isNotEmpty
                          ? controller.salesOverTimeData.map((e) => e.amount).reduce((a, b) => a > b ? a : b) * 1.1
                          : 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots:
                          controller.salesOverTimeData.asMap().entries.map((entry) {
                            return FlSpot(entry.key.toDouble(), entry.value.amount);
                          }).toList(),
                      isCurved: true,
                      gradient: LinearGradient(colors: [AppColor.primaryColor, AppColor.primaryColor.withOpacity(0.5)]),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(radius: 4, color: AppColor.primaryColor, strokeWidth: 2, strokeColor: Colors.white);
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [AppColor.primaryColor.withOpacity(0.3), AppColor.primaryColor.withOpacity(0.1)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector(StatsController controller) {
    return Container(
      width: 150,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: controller.selectedPeriod.value,
          icon: const Icon(Icons.keyboard_arrow_down, size: 20),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
          items:
              controller.periodOptions.map((String period) {
                return DropdownMenuItem<String>(value: period, child: Text(period));
              }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              controller.changePeriod(newValue);
            }
          },
        ),
      ),
    );
  }
}
