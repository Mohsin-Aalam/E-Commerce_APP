import 'package:ecomerce_app/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecomerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:ecomerce_app/presentation/screens/auth/providers/login_provider.dart';
import 'package:ecomerce_app/presentation/screens/auth/sign_up.dart';
import 'package:ecomerce_app/presentation/screens/splash/splashscreen.dart';
import 'package:ecomerce_app/presentation/widgets/primary_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple, Colors.blue],
                tileMode: TileMode.repeated,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight)),
        child: Scaffold(
          body: SafeArea(
              child: Form(
            key: provider.formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                (provider.error != "")
                    ? Text(
                        provider.error,
                        style: const TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
                PrimaryTextField(
                  labelText: 'Email Address',
                  controller: provider.emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email address is required!";
                    }
                    if (!EmailValidator.validate(value.trim())) {
                      return "Invalid Email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryTextField(
                  labelText: 'password',
                  controller: provider.passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "password is required!";
                    }

                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                        padding: EdgeInsetsDirectional.zero,
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 18),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                CupertinoButton(
                  onPressed: provider.logIn,
                  color: Colors.blue,
                  child: (provider.isLoading)
                      ? const Text("...")
                      : const Text('Log In'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      "Don't have an account?",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
                    ),
                    CupertinoButton(
                        padding: EdgeInsetsDirectional.zero,
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18),
                        ))
                  ],
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
