import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';

class TabletTextField extends StatelessWidget {
  final TextEditingController? controller;
  final double? width;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const TabletTextField({
    Key? key,
    this.controller,
    this.width,
    this.hintText,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        color: MyColors.ash,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          maxLines: 1,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: keyboardType == TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText:  hintText, 
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(bottom: 16),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w200,
            ),
            errorText: validator != null ? validator!(controller?.text) : null,
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
