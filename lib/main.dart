import 'dart:developer';

import 'package:auto_animated/auto_animated.dart';
import 'package:ecommerce_bloc/constants/app_colors.dart';
import 'package:ecommerce_bloc/features/product/bloc/product_bloc.dart';
import 'package:ecommerce_bloc/helpers/all_routes.dart';
import 'package:ecommerce_bloc/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'constants/custome_theme.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/navigation_service.dart';
import 'helpers/responsive_utils.dart';
import 'networks/dio/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  diSetup();
  DioSingleton.instance.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();

    return AnimateIfVisibleWrapper(
      showItemInterval: const Duration(milliseconds: 150),
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (bool didPop, result) async {
          showMaterialDialog(context);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            SizeConfig.init(context); // Initialize SizeConfig
            return const AdaptiveScreen();
          },
        ),
      ),
    );
  }
}

class AdaptiveScreen extends StatelessWidget {
  const AdaptiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          log('screen wight >>>>>>>>>>>>>> ${constraints.maxWidth}');
          log('screen wight >>>>>>>>>>>>>> ${constraints.maxHeight}');
          log('screen wight >>>>>>>>>>>>>> ${constraints.maxHeight}');
          // Tablet Layout
          return const TabletLayout();
        } else {
          // Mobile Layout
          return const MobileLayout();
        }
      },
    );
  }
}

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ProductBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: CustomTheme.kToDark,
          useMaterial3: false,
          scaffoldBackgroundColor: AppColors.scaffoldColor,
        ),
        debugShowCheckedModeBanner: false,
        builder: (context, widget) {
          return MediaQuery(data: MediaQuery.of(context), child: widget!);
        },
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: NavigationService.navigatorKey,
        home: const Loading(),
      ),
    );
  }
}

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: CustomTheme.kToDark,
        useMaterial3: false,
        scaffoldBackgroundColor: AppColors.scaffoldColor,
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        return MediaQuery(data: MediaQuery.of(context), child: widget!);
      },
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: NavigationService.navigatorKey,
      home: const Loading(),
    );
  }
}
