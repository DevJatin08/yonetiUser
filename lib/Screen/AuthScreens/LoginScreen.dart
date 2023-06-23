import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Constant/InputStyle.dart';
import 'package:userapp/Constant/validator/validator.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';
import 'package:userapp/Screen/AuthScreens/ForgetPasswordScreen.dart';
import 'package:userapp/Screen/AuthScreens/SignUpScreen.dart';
import 'package:userapp/Screen/AuthScreens/VerifyScreen.dart';
import 'package:userapp/Screen/CommonWidgets/CustomButton.dart';
import 'package:userapp/Screen/CommonWidgets/EditField.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/CommonWidgets/Snackbar.dart';
import 'package:userapp/main.dart';

class LoginScreen extends ConsumerStatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = ref.watch(userInfoProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * mainPadding,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "Welcome to\n Yoneti App",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff173143),
                        letterSpacing: 1,
                        fontFamily: 'bold',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Sign in to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontFamily: 'bold',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AuthEditField(
                    validator: (e) => Validators.validateEmail(e),
                    controller: emailController,
                    hint: "Email",
                    inputDecoration: authInputDecoration,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AuthEditField(
                    validator: (e) => Validators.validatePassword(e),
                    controller: passwordController,
                    hint: "Password",
                    inputDecoration: authInputDecoration,
                    suffix: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ForgetPasswordScreen()));
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'bold',
                          color: darkThemeColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    fontSize: 16,
                    //    height: 20.0,
                    family: 'bold',
                    text: 'Login',
                    voidCallback: () async {
                      if (_formKey.currentState!.validate()) {
                        print(passwordController.text);
                        poploading(context);
                        ResponseData responseData =
                            await userProvider.callLogin(emailController.text,
                                passwordController.text, fcmToken.toString());
                        Navigator.pop(context);
                        if (responseData.statusCode!) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => VerifyScreen()));
                          snackbar('OTP Successfully Send', context);
                        } else {
                          snackbar(responseData.message!, context);
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: new TextSpan(
                        text: 'New to Yoneti ? ',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SignUpScreen()));
                              },
                            text: 'Signup',
                            style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 17,
                              color: darkThemeColor,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
