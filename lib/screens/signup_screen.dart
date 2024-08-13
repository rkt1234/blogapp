import 'package:blogapp/provider/signup_provider.dart';
import 'package:blogapp/screens/signin_screen.dart';
import 'package:blogapp/services/navigation_service.dart';
import 'package:blogapp/services/toast_service.dart';
import 'package:blogapp/utils/configs.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/utils/text_style.dart';
import 'package:blogapp/widgets/custom_auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  height: height * .6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Create an account",
                        textAlign: TextAlign.center,
                        style: authenticationFormStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                      Center(
                        child: InkWell(
                            onTap: () async {
                              await provider.pickImage();
                            },
                            // onTap: _getFromGallery(),
                            child: provider.pickedImage == null
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      defaultImageUrl,
                                    ),
                                    radius: height * .05,
                                    // backgroundColor: Colors.grey,
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        FileImage(provider.pickedImage!),
                                    radius: height * .05,
                                    // backgroundColor: Colors.grey,
                                  )),
                      ),
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
                        obscureText: true,
                          controller: passwordController,
                          errorText: provider.passwordError,
                          labelText: 'Password',
                          labelStyle: authenticationFormStyle),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool navigate = await provider.checkValidity(
                                emailController.text,
                                usernameController.text,
                                passwordController.text);
                            getToast(context, provider.toastMessage, provider.icon);
                            if (navigate) {
                              print(provider.jwt);
                              pushReplacement(context, const SigninScreen());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF1A80E5), // Button text color
                                      
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(15), // Rounded corners
                            ),
                            elevation: 2, // Button elevation
                            textStyle: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          child:  Text("Continue", style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16),),
                        ),
                      ),
                  
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            pushReplacement(context, SigninScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.grey[100], // Button text color
                                      
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(15), // Rounded corners
                            ),
                            elevation: 2, // Button elevation
                            textStyle: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          child:  Text(
                            "Login",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
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
