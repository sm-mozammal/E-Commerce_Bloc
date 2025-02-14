import 'package:ecommerce_bloc/common_wigdets/common_button.dart';
import 'package:ecommerce_bloc/common_wigdets/custom_textfiled.dart';
import 'package:ecommerce_bloc/constants/app_assets.dart';
import 'package:ecommerce_bloc/constants/from_validation.dart';
import 'package:ecommerce_bloc/constants/text_font_style.dart';
import 'package:ecommerce_bloc/features/authentication/bloc/login_bloc.dart';
import 'package:ecommerce_bloc/features/authentication/bloc/login_event.dart';
import 'package:ecommerce_bloc/features/authentication/bloc/login_state.dart';
import 'package:ecommerce_bloc/helpers/toast.dart';
import 'package:ecommerce_bloc/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UIHelper.verticalSpaceLarge,
                Image.asset(Assets.login),
                UIHelper.verticalSpaceMedium,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'প্রবেশ করুন',
                    style: TextFontStyle.textStyle20RobotoW400,
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                CustomTextFormField(
                    labelText: 'Email',
                    controller: _emailController,
                    isPrefixIcon: false,
                    validator: (value) => InputValidator.validateEmail(value)),
                UIHelper.verticalSpaceMedium,
                CustomTextFormField(
                    controller: _passwordController,
                    isPrefixIcon: false,
                    labelText: 'Password',
                    validator: (value) =>
                        InputValidator.validatePassword(value)),
                UIHelper.verticalSpaceMedium,
                BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) async {
                  if (state is LoginLoading) {
                    isLoading = true;
                  }
                  if (state is LoginSuccessfull) {
                    isLoading = false;
                    ToastUtil.showLongToast(state.loginResponse.message!);
                  }
                  if (state is LoginError) {
                    isLoading = false;
                    ToastUtil.showLongToast(state.errorMessage);
                  }
                }, builder: (context, state) {
                  return CommonButton(
                      isLoading: isLoading,
                      text: 'Login',
                      onPressed: () {
                        if (_fromKey.currentState?.validate() ?? false) {
                          _emailController.text;
                          context.read<LoginBloc>().add(LogedInEvent(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim()));
                        }
                      });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
