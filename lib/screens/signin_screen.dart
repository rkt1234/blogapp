import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/utils/text_style.dart';
import 'package:blogapp/widgets/custom_elevatedbutton.dart';
import 'package:blogapp/widgets/custom_auth_textfield.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
              const Text("Register"),
               AuthCustomTextField(labelText: 'E-mail',
                labelStyle: authenticationFormStyle,
              ),
               AuthCustomTextField(labelText: 'Password',
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
                  const Text("Already have an account ? "),
                  InkWell(
                    onTap: () {},
                    child: const Text(" Login"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
