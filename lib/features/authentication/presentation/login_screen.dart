import 'package:ecommerce_bloc/common_wigdets/common_button.dart';
import 'package:ecommerce_bloc/features/authentication/bloc/login_bloc.dart';
import 'package:ecommerce_bloc/features/authentication/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonButton(
                text: 'Login',
                onPressed: () {
                  context.read<LoginBloc>().add(LogedInEvent(
                      email: 'admin@gmail.com', password: '12345678'));
                })
          ],
        ),
      ),
    );
  }
}
