import 'package:blogapp/provider/signin_provider.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/utils/text_style.dart';
import 'package:blogapp/widgets/custom_elevatedbutton.dart';
import 'package:blogapp/widgets/custom_auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<SigninProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(appHeader, style: appTitleStyle),
          ),
        ),
        body: Center(
          child: Container(
            height: height * .35,
            width: height * .35,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Login",
                  style: authenticationFormStyle,
                ),
                AuthCustomTextField(
                  errorText: provider.emailError,
                  controller: emailController,
                  labelText: 'E-mail',
                  labelStyle: authenticationFormStyle,
                ),
                AuthCustomTextField(
                  errorText: provider.passwordError,
                  controller: passwordController,
                  labelText: 'Password',
                  labelStyle: authenticationFormStyle,
                ),
                const CustomElevatedButton(),
                Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ? ",
                      style: authenticationFormStyle,
                    ),
                    InkWell(
                      onTap: () {
                        provider.checkValidity(
                            emailController.text, passwordController.text);
                      },
                      child: Text(
                        " Signup",
                        style: authenticationFormStyle,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
