import 'package:blogapp/provider/signin_provider.dart';
import 'package:blogapp/screens/home_screen.dart';
import 'package:blogapp/screens/signup_screen.dart';
import 'package:blogapp/services/navigation_service.dart';
import 'package:blogapp/services/toast_service.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/utils/text_style.dart';
import 'package:blogapp/widgets/custom_auth_textfield.dart';
import 'package:blogapp/widgets/custom_elevatedbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late SharedPreferences pref;
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Consumer<SigninProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(appHeader, style: appTitleStyle),
          ),
        ),
        body:Stack(
          children: [
             Center(
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
                      ElevatedButton(
                        onPressed: () async {
                          bool navigate = await provider.checkValidity(
                              emailController.text, passwordController.text);
                          print(provider.toastMessage);
                          getToast(
                              context, provider.toastMessage, provider.icon);
                          if (navigate) {
                            await pref.setString('jwt_token', provider.jwt);
                            print(provider.jwt);
                            pushReplacement(
                                context,
                                HomeScreen(
                                  token: provider.jwt,
                                  // token: jwt,
                                ));
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
                            "Don't have an account ? ",
                            style: authenticationFormStyle,
                          ),
                          InkWell(
                            onTap: () async {
                              pushReplacement(context, SignupScreen());
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
              provider.isLoading?const Center(child: CircularProgressIndicator(),):Container()
          ],
        )
      );
    });
  }
}
