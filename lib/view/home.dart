import 'package:admin_ecommerce_app/data/model/categoresis_model.dart';
import 'package:admin_ecommerce_app/widget/categorywidget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/product');
        },
        tooltip: 'Go to Product Page',
        child: const Icon(Icons.navigate_next),
      ),
      appBar: AppBar(title: const Text('Product Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...List.generate(
              2,
              (index) => Categorywidget(
                categoriesModel: CategoriesModel(
                  categoriesId: 1,
                  categoriesName: 'Category $index',
                  categoriesNamaAr: 'Category $index Ar',
                  categoriesImage: 'https://via.placeholder.com/150',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
