import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';

class Dialogfun {
  void showErrorDialog(String title, String message, Function()? onTap) {
    _showModernDialog(Get.context!, onTap, title, message, DialogType.error);
  }

  void showSuccessDialog(String title, String message, Function()? onTap) {
    _showModernDialog(Get.context!, onTap, title, message, DialogType.success);
  }

  void showWarningDialog(String title, String message, Function()? onTap) {
    _showModernDialog(Get.context!, onTap, title, message, DialogType.warning);
  }

  void showInfoDialog(String title, String message, Function()? onTap) {
    _showModernDialog(Get.context!, onTap, title, message, DialogType.info);
  }

  void showSuccessSnack(String title, String message) {
    _showModernSnackbar(Get.context!, title, message, SnackType.success);
  }

  void showErrorSnack(String title, String message) {
    _showModernSnackbar(Get.context!, title, message, SnackType.error);
  }

  void showWarningSnack(String title, String message) {
    _showModernSnackbar(Get.context!, title, message, SnackType.warning);
  }

  void showInfoSnack(String title, String message) {
    _showModernSnackbar(Get.context!, title, message, SnackType.info);
  }

  Future _showModernSnackbar(BuildContext context, String title, String message, SnackType type) async {
    final config = _getSnackConfig(type);

    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      colorText: Colors.green,
      margin: const EdgeInsets.all(20),
      borderRadius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 600),
      titleText: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: config.gradient,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: config.shadowColor, blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Icon(config.icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green, letterSpacing: 0.3)),
          ),
        ],
      ),
      messageText: Padding(
        padding: const EdgeInsets.only(left: 50, top: 6),
        child: Text(message, style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.4)),
      ),
      boxShadows: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 24, offset: const Offset(0, 12), spreadRadius: 0)],
      borderColor: config.borderColor.withOpacity(0.2),
      borderWidth: 1.5,
      shouldIconPulse: false,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
      leftBarIndicatorColor: config.borderColor,
    );
  }

  Future _showModernDialog(BuildContext context, Function()? onTap, String title, String message, DialogType type) async {
    final config = _getDialogConfig(type);

    return await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.65),
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            constraints: const BoxConstraints(maxWidth: 420),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(color: config.shadowColor.withOpacity(0.2), blurRadius: 40, offset: const Offset(0, 20), spreadRadius: 0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon Section with Animated Background
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(32, 40, 32, 32),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [config.primaryColor.withOpacity(0.08), config.primaryColor.withOpacity(0.03)],
                      ),
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                    ),
                    child: Column(
                      children: [
                        // Animated Icon Container
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            gradient: config.gradient,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: config.shadowColor, blurRadius: 24, offset: const Offset(0, 10))],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer ring animation effect
                              Container(
                                width: 96,
                                height: 96,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white.withOpacity(0.3), width: 3),
                                ),
                              ),
                              // Icon
                              Icon(config.icon, color: Colors.white, size: 48),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Title
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content Section
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 8, 32, 32),
                    child: Column(
                      children: [
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 16, height: 1.6, letterSpacing: 0.2),
                        ),
                        const SizedBox(height: 32),

                        // Modern Action Button
                        Container(
                          width: double.infinity,
                          height: 58,
                          decoration: BoxDecoration(
                            gradient: config.gradient,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [BoxShadow(color: config.shadowColor, blurRadius: 16, offset: const Offset(0, 8), spreadRadius: 0)],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(18),
                              splashColor: Colors.white.withOpacity(0.2),
                              highlightColor: Colors.white.withOpacity(0.1),
                              onTap: () {
                                Navigator.of(context).pop();
                                if (onTap != null) onTap();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "got_it".tr,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Icon(Icons.check_circle_outline, color: Colors.white, size: 22),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Optional: Add a subtle secondary action
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text('Close', style: TextStyle(color: Colors.grey.shade600, fontSize: 15, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  DialogConfig _getDialogConfig(DialogType type) {
    switch (type) {
      case DialogType.success:
        return DialogConfig(
          icon: Icons.check_circle_rounded,
          gradient: const LinearGradient(colors: [Colors.green, Color(0xFF059669)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          primaryColor: Colors.green,
          shadowColor: Colors.green.withOpacity(0.4),
        );
      case DialogType.error:
        return DialogConfig(
          icon: Icons.cancel_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          primaryColor: const Color(0xFFEF4444),
          shadowColor: const Color(0xFFEF4444).withOpacity(0.4),
        );
      case DialogType.warning:
        return DialogConfig(
          icon: Icons.warning_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFFF59E0B), Color(0xFFEA580C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          primaryColor: const Color(0xFFF59E0B),
          shadowColor: const Color(0xFFF59E0B).withOpacity(0.4),
        );
      case DialogType.info:
        return DialogConfig(
          icon: Icons.info_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          primaryColor: const Color(0xFF3B82F6),
          shadowColor: const Color(0xFF3B82F6).withOpacity(0.4),
        );
    }
  }

  SnackConfig _getSnackConfig(SnackType type) {
    switch (type) {
      case SnackType.success:
        return SnackConfig(
          icon: Icons.check_circle_rounded,
          gradient: const LinearGradient(colors: [Colors.green, Color(0xFF059669)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderColor: Colors.green,
          shadowColor: Colors.green.withOpacity(0.3),
        );
      case SnackType.error:
        return SnackConfig(
          icon: Icons.cancel_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderColor: const Color(0xFFEF4444),
          shadowColor: const Color(0xFFEF4444).withOpacity(0.3),
        );
      case SnackType.warning:
        return SnackConfig(
          icon: Icons.warning_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFFF59E0B), Color(0xFFEA580C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderColor: const Color(0xFFF59E0B),
          shadowColor: const Color(0xFFF59E0B).withOpacity(0.3),
        );
      case SnackType.info:
        return SnackConfig(
          icon: Icons.info_rounded,
          gradient: const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderColor: const Color(0xFF3B82F6),
          shadowColor: const Color(0xFF3B82F6).withOpacity(0.3),
        );
    }
  }
}

enum DialogType { success, error, warning, info }

enum SnackType { success, error, warning, info }

class DialogConfig {
  final IconData icon;
  final LinearGradient gradient;
  final Color primaryColor;
  final Color shadowColor;

  DialogConfig({required this.icon, required this.gradient, required this.primaryColor, required this.shadowColor});
}

class SnackConfig {
  final IconData icon;
  final LinearGradient gradient;
  final Color borderColor;
  final Color shadowColor;

  SnackConfig({required this.icon, required this.gradient, required this.borderColor, required this.shadowColor});
}
