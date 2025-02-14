import 'package:ecommerce_bloc/constants/app_colors.dart';
import 'package:flutter/material.dart';

final class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: AppColors.scaffoldColor),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SizedBox(
              //   height: 200,
              //   width: 200,
              //   child: Image.asset(
              //     Assets.icons.logo.path,
              //   ),
              // )
            ]),
      ),
    );
  }
}
