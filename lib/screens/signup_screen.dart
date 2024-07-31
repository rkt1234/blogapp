import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/utils/text_style.dart';
import 'package:blogapp/widgets/custom_auth_textfield.dart';
import 'package:blogapp/widgets/custom_elevatedbutton.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: height * .5,
          width: height * .45,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Register",
                style: authenticationFormStyle,
              ),
              InkWell(
                  child: CircleAvatar(
                radius: height * .05,
                backgroundColor: const Color.fromARGB(255, 252, 248, 248),
              )),
              AuthCustomTextField(labelText: 'E-mail',labelStyle: authenticationFormStyle,),
               AuthCustomTextField(labelText: 'Username', labelStyle: authenticationFormStyle),
               AuthCustomTextField(labelText: 'Password',labelStyle:  authenticationFormStyle),
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
                    "Already have an account ? ",
                    style: authenticationFormStyle,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      " Login",
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
  }
}
