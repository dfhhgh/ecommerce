import 'package:ecommerce/core/them_light/App_color_light.dart';
import 'package:flutter/material.dart';

class gradientbutton extends StatelessWidget {
  final GlobalKey<FormState> keyform;
  const gradientbutton({
    super.key,
    required this.w,
    required this.h,
    required this.keyform,
    required this.text,
  });

  final double w;
  final double h;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: w * 0.5,
      height: h * 0.06,
      decoration: BoxDecoration(
        gradient: AppColorsLight.primaryGradient2,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            keyform.currentState!.validate();
          },
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: AppColorsLight.background,
                fontWeight: FontWeight.bold,
                fontSize: w * 0.05,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
