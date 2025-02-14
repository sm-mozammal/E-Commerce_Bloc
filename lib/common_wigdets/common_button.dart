import 'package:ecommerce_bloc/constants/app_colors.dart';
import 'package:ecommerce_bloc/constants/text_font_style.dart';
import 'package:ecommerce_bloc/helpers/responsive_utils.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color borderColor;
  final double? width;
  final double? height;
  final TextStyle? style;
  final double borderRadius;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.allPrimaryColor,
    this.borderColor = AppColors.allPrimaryColor,
    this.width,
    this.height,
    this.style,
    this.borderRadius = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity, // 80% of screen width
      height: height ?? SizeConfig.height(6), // 6% of screen height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side:
                  BorderSide(width: SizeConfig.width(0.1), color: borderColor)),
        ),
        onPressed: onPressed,
        child: Text(text,
            style: style ??
                TextFontStyle.textStyle20RobotoW400.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.cFFFFFF)),
      ),
    );
  }
}
