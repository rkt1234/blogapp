import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/utils/text_style.dart';
import 'package:blogapp/widgets/custom_elevatedbutton.dart';
import 'package:blogapp/widgets/custom_textfield.dart';
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
          child: Text(appHeader, style: titleStyle),
        ),
      ),
      body: Center(
        child: Container(
          height: height*.38,
          width: height*.38,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Register"),
              InkWell(child: CircleAvatar(radius: height*.05,)),
              const CustomTextField(),
              const CustomTextField(),
              const CustomTextField(),
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
