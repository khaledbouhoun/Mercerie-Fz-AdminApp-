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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async => true,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(),
              child: SafeArea(
                child: Form(
                  key: controller.formKey,
                  child: RefreshIndicator.adaptive(
                    color: Colors.white,
                    backgroundColor: AppColor.primaryColor,
                    onRefresh: () async {
                      await controller.getEmployees();
                      await controller.fetchStores();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),

                            /// Logo with Enhanced Container
                            Hero(
                              tag: 'app_logo',
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(28),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.primaryColor.withOpacity(0.12),
                                      blurRadius: 30,
                                      offset: const Offset(0, 15),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Image.asset(AppImageAsset.logo, width: 120, height: 120, fit: BoxFit.contain),
                              ),
                            ),

                            const SizedBox(height: 40),

                            /// Welcome Text
                            Text(
                              'Welcome Back',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2D3142),
                                letterSpacing: 0.5,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              'Sign in to continue your work',
                              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600, letterSpacing: 0.2),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 50),

                            /// Modern Login Card
                            Container(
                              padding: const EdgeInsets.all(28),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.primaryColor.withOpacity(0.12),
                                    blurRadius: 30,
                                    offset: const Offset(0, 5),
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Employee Dropdown
                                  _buildSectionLabel('Select Employee', Icons.person_outline_rounded),
                                  const SizedBox(height: 12),
                                  DropdownButtonFormField<EmployeModel>(
                                    dropdownColor: Colors.white,
                                    isExpanded: true,
                                    isDense: false,
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(20),
                                    decoration: InputDecoration(
                                      hintText: 'Choose your profile',
                                      hintStyle: TextStyle(color: Colors.grey.shade400),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        borderSide: const BorderSide(color: Colors.red, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
                                      ),
                                      prefixIcon: Container(
                                        margin: const EdgeInsets.all(12),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [AppColor.primaryColor.withOpacity(0.15), AppColor.primaryColor.withOpacity(0.08)],
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: SvgPicture.asset(AppSvg.profile, color: AppColor.primaryColor, width: 20, height: 20),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade50,
                                    ),
                                    initialValue: controller.selectedEmployee,
                                    items:
                                        controller.employees
                                            .map(
                                              (e) => DropdownMenuItem<EmployeModel>(
                                                value: e,
                                                child: Text(
                                                  e.employeeName ?? 'Unknown',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF2D3142),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                    onChanged: (newVal) {
                                      controller.selectedEmployee = newVal;
                                    },
                                    icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.primaryColor),
                                  ),

                                  const SizedBox(height: 24),

                                  /// Password Field
                                  _buildSectionLabel('Password', Icons.lock_outline_rounded),
                                  const SizedBox(height: 12),
                                  Obx(() {
                                    return TextFormField(
                                      controller: controller.passwordController,
                                      obscureText: controller.hidePassword.value,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) return 'Password is required';
                                        if (val.length < 3) return 'Password must be at least 3 characters';
                                        return null;
                                      },
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your password',
                                        hintStyle: TextStyle(color: Colors.grey.shade400),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                        prefixIcon: Container(
                                          margin: const EdgeInsets.all(12),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [AppColor.primaryColor.withOpacity(0.15), AppColor.primaryColor.withOpacity(0.08)],
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: SvgPicture.asset(AppSvg.lock, color: AppColor.primaryColor, width: 20, height: 20),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            controller.hidePassword.value = !controller.hidePassword.value;
                                          },
                                          icon: Container(
                                            padding: const EdgeInsets.all(8),
                                            child: SvgPicture.asset(
                                              controller.hidePassword.value ? AppSvg.eyeoff : AppSvg.eyeon,
                                              color: AppColor.primaryColor,
                                              width: 22,
                                              height: 22,
                                            ),
                                          ),
                                        ),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                                        filled: true,
                                        fillColor: Colors.grey.shade50,
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(18),
                                          borderSide: const BorderSide(color: Colors.red, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(18),
                                          borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(18),
                                          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
                                        ),
                                        errorStyle: const TextStyle(fontSize: 12, height: 1.2),
                                      ),
                                      keyboardType: TextInputType.visiblePassword,
                                      textCapitalization: TextCapitalization.none,
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                      textInputAction: TextInputAction.done,
                                      onFieldSubmitted: (_) {
                                        if (controller.formKey.currentState!.validate()) {
                                          controller.authenticate();
                                        }
                                      },
                                    );
                                  }),

                                  const SizedBox(height: 32),

                                  /// Login Button
                                  Obx(() {
                                    return Container(
                                      width: double.infinity,
                                      height: 58,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [AppColor.primaryColor, AppColor.primaryColor.withOpacity(0.85)],
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColor.primaryColor.withOpacity(0.4),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(18),
                                          onTap:
                                              controller.isLoading.value
                                                  ? null
                                                  : () {
                                                    if (controller.formKey.currentState!.validate()) {
                                                      controller.authenticate();
                                                    }
                                                  },
                                          child: Container(
                                            alignment: Alignment.center,
                                            child:
                                                controller.isLoading.value
                                                    ? const SizedBox(
                                                      height: 26,
                                                      width: 26,
                                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                                                    )
                                                    : Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Text(
                                                          'Sign In',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 17,
                                                            letterSpacing: 0.5,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 12),
                                                        Container(
                                                          padding: const EdgeInsets.all(6),
                                                          decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.2),
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                                                        ),
                                                      ],
                                                    ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),

                            const SizedBox(height: 30),

                            /// Footer Text
                            Text(
                              'Secure login with biometric authentication',
                              style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionLabel(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColor.primaryColor),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF2D3142), letterSpacing: 0.3)),
      ],
    );
  }
}
