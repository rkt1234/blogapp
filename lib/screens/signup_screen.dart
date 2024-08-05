import 'package:blogapp/provider/signup_provider.dart';
import 'package:blogapp/screens/signin_screen.dart';
import 'package:blogapp/services/navigation_service.dart';
import 'package:blogapp/services/toast_service.dart';
import 'package:blogapp/utils/configs.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/utils/text_style.dart';
import 'package:blogapp/widgets/custom_auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController usernameController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Consumer<SignupProvider>(builder: (context, provider, child) {
      return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(appHeader, style: appTitleStyle),
            ),
          ),
          body: Stack(
            children: [
              Center(
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
                        onTap: ()async{
                          await provider.pickImage();
                        },
                        // onTap: _getFromGallery(),
                          child: provider.pickedImage==null? CircleAvatar(
                        backgroundImage:  NetworkImage(
                          defaultImageUrl,
                        ),
                        radius: height * .05,
                        // backgroundColor: Colors.grey,
                      ): CircleAvatar(
                                  backgroundImage:   FileImage(provider.pickedImage!),
                                  radius: height * .05,
                                  // backgroundColor: Colors.grey,
                                )),
                      AuthCustomTextField(
                        controller: emailController,
                        errorText: provider.emailError,
                        labelText: 'E-mail',
                        labelStyle: authenticationFormStyle,
                      ),
                      AuthCustomTextField(
                          controller: usernameController,
                          errorText: provider.usernameError,
                          labelText: 'Username',
                          labelStyle: authenticationFormStyle),
                      AuthCustomTextField(
                          controller: passwordController,
                          errorText: provider.passwordError,
                          labelText: 'Password',
                          labelStyle: authenticationFormStyle),
                      ElevatedButton(
                        onPressed: () async {
                          bool navigate = await provider.checkValidity(
                              emailController.text,
                              usernameController.text,
                              passwordController.text);
                          getToast(
                              context, provider.toastMessage, provider.icon);
                          if (navigate) {
                            print(provider.jwt);
                            pushReplacement(context, const SigninScreen());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue, // Button text color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                          ),
                          elevation: 5, // Button elevation
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text("text"),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
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
                            onTap: () async {
                              push(context, const SigninScreen());
                            },
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
              provider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
            ],
          ));
    });
  }
}
