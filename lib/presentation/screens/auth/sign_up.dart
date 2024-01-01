import 'package:ecomerce_app/presentation/screens/auth/providers/signup_provider.dart';
import 'package:ecomerce_app/presentation/widgets/primary_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = 'signUp';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignupProvider>(context);
    return Container(
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
                'Create Account',
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
                      style: TextStyle(color: Colors.red),
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
                labelText: 'Password',
                controller: provider.passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "password is required!";
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryTextField(
                labelText: ' Confirm Password',
                controller: provider.conPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Confirm your password!";
                  }
                  if (value.trim() != provider.passwordController.text.trim()) {
                    return "Password do not match";
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              CupertinoButton(
                onPressed: provider.createAccount,
                color: Colors.blue,
                child: (provider.isLoading)
                    ? const Text("...")
                    : const Text('Create Account'),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    "Already  have an account?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
                  ),
                  CupertinoButton(
                      padding: EdgeInsetsDirectional.zero,
                      onPressed: () {},
                      child: const Text(
                        'Log In',
                        style: TextStyle(fontSize: 18),
                      ))
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
