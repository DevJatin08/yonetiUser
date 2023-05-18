import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Constant/InputStyle.dart';
import 'package:userapp/Constant/validator/validator.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';
import 'package:userapp/Screen/CommonWidgets/CustomButton.dart';
import 'package:userapp/Screen/CommonWidgets/EditField.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/CommonWidgets/Snackbar.dart';
import 'package:userapp/Screen/NavigationScreens/BaseScreen.dart';
import 'package:userapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart' as ge;

class SignUpScreen extends ConsumerStatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int selectAccount = 0;
  String? token;

  @override
  Widget build(BuildContext context) {
    final userProvider = ref.watch(userInfoProvider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * mainPadding,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Center(
                  child: Container(
                    width: size.width * 0.4,
                    child: Text(
                      'Signup to Yoneti',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: thirdColor,
                        fontFamily: 'bold',
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                AuthEditField(
                  validator: (e) => Validators.validateEmail(e),
                  // e!.isEmpty ? "Enter the email address" : null

                  controller: emailController,
                  inputDecoration: authInputDecoration,
                  hint: 'Email',
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                AuthEditField(
                  validator: (e) => Validators.validatePassword(e),
                  suffix: true,
                  controller: passwordController,
                  inputDecoration: authInputDecoration,
                  hint: 'Password',
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                AuthEditField(
                  controller: phoneController,
                  isPhoneNumber: true,
                  validator: (e) => Validators.validateMobileNumber(e),
                  // validator: (e) => e!.isEmpty
                  //     ? "Enter the Phone number"
                  //     : e.length < 10
                  //         ? "Phone number must be 10 digit length"
                  //         : null,
                  keyboardType: TextInputType.phone,
                  inputDecoration: authInputDecoration,
                  hint: 'Phone Number',
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                CustomButton(
                  fontSize: 16,
                  //    height: 20.0,
                  family: 'bold',
                  text: 'Signup',
                  voidCallback: () async {
                    if (_formKey.currentState!.validate()) {
                      poploading(context);

                      ResponseData responseData = await userProvider.callSignIn(
                          emailController.text.toString(),
                          passwordController.text.toString(),
                          phoneController.text.toString(),
                          fcmToken.toString());
                      Navigator.pop(context);

                      if (responseData.statusCode!) {
                        Navigator.pop(context);
                      }

                      snackbar(responseData.message!, context);
                    }
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                RichText(
                  text: new TextSpan(
                      text: 'Existing Yoneti?  ',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) => LoginScreen()));
                            },
                          text: 'Login',
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 16,
                              color: primaryColor),
                        ),
                      ]),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                customBtn('Facebook', () {
                  facebookLogin(context, userProvider);
                }, FontAwesomeIcons.facebook),
                SizedBox(
                  height: size.height * 0.02,
                ),
                customBtn('Google', () async {
                  await signInWithGoogle().then((value) async {
                    poploading(context);
                    ResponseData responseData =
                        await userProvider.callSocialLogin(value.user!.email!,
                            value.user!.uid, 'Google', fcmToken.toString(), '');
                    if (responseData.statusCode!) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => BaseHomeWidget()));
                    } else {
                      snackbar(responseData.message!, context);
                    }
                  });
                }, FontAwesomeIcons.google),
                SizedBox(
                  height: size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<auth.UserCredential> signInWithGoogle() async {
    auth.User googleauthUser;
    final ge.GoogleSignInAccount? googleUser = await ge.GoogleSignIn().signIn();
    final ge.GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await auth.FirebaseAuth.instance
        .signInWithCredential(credential)
        .whenComplete(() async => {
              googleauthUser = auth.FirebaseAuth.instance.currentUser!,
            });

    return await auth.FirebaseAuth.instance.signInWithCredential(credential);
  }

  Widget customBtn(
      String serviceProvider, VoidCallback callback, IconData iconData) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: callback,
      child: Container(
        width: size.width * buttonWidth,
        height: size.width * 0.13,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(button_radius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.04,
            ),
            Icon(
              iconData,
              color: Colors.white,
            ),
            SizedBox(
              width: size.width * 0.04,
            ),
            Text(
              "Continue With ${serviceProvider}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> facebookLogin(context, useProvider) async {
    // await FacebookAuth.instance.logOut();
    FirebaseMessaging.instance.getToken().then((value) {
      token = value;
    });
    final LoginResult result = await FacebookAuth.instance.login(permissions: [
      'email',
      'public_profile',
    ], loginBehavior: LoginBehavior.webOnly);

    switch (result.status) {
      case LoginStatus.success:
        final AccessToken accessToken = result.accessToken!;

        final graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v3.3/me?fields=name,picture,friends,email&access_token=${accessToken.token}'));
        final profile = json.decode(graphResponse.body);

        poploading(context);
        ResponseData responseData = await useProvider.callSocialLogin(
            profile['email'].toString(),
            profile['id'].toString(),
            'Facebook',
            fcmToken.toString(),
            '');
        Navigator.pop(context);
        if (responseData.statusCode!) {
          Navigator.pop(context);

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => BaseHomeWidget()));
        } else {
          snackbar(responseData.message!, context);
        }
        // facebookLoginApi(
        //     context: context,
        //     accessToken: accessToken.token,
        //     providerid: profile['id'].toString(),
        //     email: profile['email'].toString(),
        //     firstname: profile['name'].toString(),
        //     deviceToken: token);

        break;
      case LoginStatus.cancelled:
        snackbar('Facebook login cancelled by user', context);

        break;
      case LoginStatus.failed:
        snackbar('Login Failed', context);

        break;
      case LoginStatus.operationInProgress:
        snackbar('Facebook login is in progress!', context);

        break;
    }
  }
}
