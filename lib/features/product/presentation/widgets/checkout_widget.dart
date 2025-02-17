import 'package:ecommerce_bloc/common_wigdets/common_button.dart';
import 'package:ecommerce_bloc/constants/app_colors.dart';
import 'package:ecommerce_bloc/constants/text_font_style.dart';
import 'package:ecommerce_bloc/helpers/navigation_service.dart';
import 'package:ecommerce_bloc/helpers/responsive_utils.dart';
import 'package:flutter/material.dart';

class CheckoutPopup extends StatefulWidget {
  const CheckoutPopup({super.key});

  @override
  State<CheckoutPopup> createState() => _CheckoutPopupState();
}

class _CheckoutPopupState extends State<CheckoutPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "চেকআউট নিশ্চিত করুন",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Divider(thickness: 1),
              ...[
                {
                  "title": "একটি ছোট প্যাকেট (10x6.5x3.5)",
                  "price": "৳53.50",
                },
                {
                  "title":
                      "একটি মাঝারি প্যাকেট মূল্যবান পণ্যদের জন্য (10x8x6.0)",
                  "price": "৳164.00",
                },
                {
                  "title": "একটি প্রিমিয়াম প্যাকেট",
                  "price": "৳780.00",
                },
                {
                  "title":
                      "একটি প্রিমিয়াম প্যাকেট মূল্যবান পণ্যদের জন্য (12x10x10.0)",
                  "price": "৳800.00",
                },
              ].map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item["title"]!,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Text(
                        item["price"]!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Divider(thickness: 1),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "মোট",
                      style: TextFontStyle.textStyle16Roboto,
                    ),
                    Text(
                      "৳1797.50",
                      style: TextFontStyle.textStyle16Roboto,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonButton(
                    text: "বাতিল",
                    onPressed: () {
                      NavigationService.goBack;
                    },
                    width: SizeConfig.width(30),
                    style: TextFontStyle.textStyle12Roboto
                        .copyWith(color: AppColors.cFFFFFF),
                  ),
                  SizedBox(width: 8),
                  CommonButton(
                    text: "নিশ্চিত করুন",
                    onPressed: () {
                      NavigationService.goBack;
                    },
                    width: SizeConfig.width(30),
                    style: TextFontStyle.textStyle12Roboto
                        .copyWith(color: AppColors.cFFFFFF),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
