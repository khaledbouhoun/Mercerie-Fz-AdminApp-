import 'package:admin_ecommerce_app/controller/auth_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/data/model/employe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColor.background,
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async => true,
            child: Container(
              color: AppColor.background,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Form(
                key: controller.formKey,
                child: RefreshIndicator.adaptive(
                  onRefresh: () async {
                    await controller.getEmployees();
                  },
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      // Logo
                      SizedBox(height: 30),
                      Center(child: SizedBox(width: 150, child: Image.asset(AppImageAsset.logo, fit: BoxFit.contain))),
                      const SizedBox(height: 10),
                      // Title
                      Center(
                        child: Text('Login to Your Account', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 10),
                      // Subtitle
                      Center(
                        child: Text(
                          'Please select your employee profile and enter your password to continue.',
                          style: theme.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 25),
                      // Employee dropdown
                      DropdownButtonFormField<EmployeModel>(
                        dropdownColor: AppColor.white,
                        isExpanded: false,
                        isDense: true,

                        borderRadius: BorderRadius.circular(20),
                        decoration: InputDecoration(
                          labelText: 'Employee',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          labelStyle: TextStyle(color: AppColor.primaryColor),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: AppColor.grey, width: 1),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(AppSvg.profile, color: AppColor.primaryColor),
                          ),
                          filled: true,
                          fillColor: AppColor.background,
                        ),
                        value: controller.selectedEmployee,
                        items:
                            controller.employees
                                .map((e) => DropdownMenuItem<EmployeModel>(value: e, child: Text(e.employeeName ?? 'Unknown')))
                                .toList(),
                        onChanged: (newVal) {
                          controller.selectedEmployee = newVal;
                        },
                      ),
                      const SizedBox(height: 15),
                      // Password field
                      Obx(() {
                        return TextFormField(
                          controller: controller.passwordController,
                          obscureText: controller.hidePassword.value,
                          validator: (val) {
                            if (val == null || val.isEmpty) return 'Password is required';
                            if (val.length < 3) return 'Password too short';
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset(AppSvg.lock, color: AppColor.primaryColor),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.hidePassword.value = !controller.hidePassword.value;
                              },
                              icon: SvgPicture.asset(
                                controller.hidePassword.value ? AppSvg.eyeoff : AppSvg.eyeon,
                                color: AppColor.primaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                            filled: true,
                            fillColor: AppColor.background,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.red, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: AppColor.grey, width: 1),
                            ),
                            labelStyle: TextStyle(color: AppColor.primaryColor),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textCapitalization: TextCapitalization.none,

                          style: const TextStyle(fontSize: 16),
                          textInputAction: TextInputAction.done,
                        );
                      }),
                      const SizedBox(height: 40),
                      // Login button
                      Obx(() {
                        return ElevatedButton(
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.authenticate();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          child:
                              controller.isLoading.value
                                  ? SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: AppColor.white))
                                  : Text('Login', style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold, fontSize: 18)),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
