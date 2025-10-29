import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextForm extends StatefulWidget {
  final String labeltext;
  final Widget iconData;
  final Widget? iconData2;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final GlobalKey<FormState> formstate;
  final bool isNumber;
  final bool? obscureText;
  final int? max;
  final TextInputAction? textInputAction;

  const CustomTextForm({
    super.key,
    this.obscureText,
    required this.labeltext,
    required this.iconData,
    this.iconData2,
    this.max,
    required this.formstate,
    required this.mycontroller,
    required this.valid,
    required this.isNumber,
    this.textInputAction = TextInputAction.next,
  });

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.12,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        maxLength: widget.max,
        controller: widget.mycontroller,
        validator: widget.valid,
        onChanged: (value) {
          setState(() {
            widget.formstate.currentState!.validate();
          });
        },
        onSaved: (newValue) {
          setState(() {
            widget.formstate.currentState!.validate();
          });
        },
        keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
        textInputAction: widget.textInputAction,
        obscureText: widget.obscureText ?? false,
        style: const TextStyle(fontFamily: "Nunito", fontSize: 20, color: AppColor.black, fontWeight: FontWeight.w600),
        cursorColor: AppColor.primaryColor,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.w600),
          labelText: widget.labeltext,
          prefixIcon: widget.iconData2,
          suffixIcon: widget.iconData,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.primaryColor),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.primaryColor),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppColor.warning), borderRadius: BorderRadius.circular(15)),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.warning),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(borderSide: const BorderSide(color: AppColor.primaryColor), borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
