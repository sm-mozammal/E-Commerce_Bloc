import 'dart:developer';

import 'package:ecommerce_bloc/features/authentication/presentation/login_screen.dart';
import 'package:ecommerce_bloc/features/product/presentation/product_screen.dart';
import 'package:ecommerce_bloc/helpers/di.dart';
import 'package:ecommerce_bloc/networks/dio/dio.dart';
import 'package:flutter/material.dart';

import 'constants/app_constants.dart';
import 'helpers/helper_methods.dart';
import 'welcome_screen.dart';

final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  loadInitialData() async {
    await Future.delayed(Durations.extralong2);
    await setInitValue();
    if (appData.read(kKeyIsLoggedIn)) {
      final token = await appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const WelcomeScreen();
    } else {
      log('>>>>>>>>>>>>>>>>>${appData.read(kKeyIsLoggedIn)}');
      return appData.read(kKeyIsLoggedIn)
          ? const ProductScreen()
          : const LoginScreen();
    }
  }
}
