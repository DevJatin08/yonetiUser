import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Constant/InputStyle.dart';
import 'package:userapp/Screen/CommonWidgets/EditField.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/CommonWidgets/Snackbar.dart';

class NewPassword extends StatefulHookWidget {
  String email;
  NewPassword({required this.email});

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _userProvider = useProvider(userInfoProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * mainPadding,
        ),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            AuthEditField(
              validator: (e) => e!.isEmpty
                  ? "Enter the password"
                  : e.length < 6
                      ? "Password must be 6 digit length"
                      : null,
              controller: passwordController,
              hint: "Password",
              inputDecoration: authInputDecoration,
              suffix: true,
            ),
            SizedBox(
              height: 15,
            ),
            AuthEditField(
              validator: (e) => e!.isEmpty
                  ? "Enter the confirm password"
                  : e.length < 6
                      ? "Password must be 6 digit length"
                      : null,
              controller: confirmPasswordController,
              hint: "Confirm Password",
              inputDecoration: authInputDecoration,
              suffix: true,
            ),

            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                if (confirmPasswordController.text == passwordController.text) {
                  poploading(context);
                  final res = await _userProvider.forgetPassword(
                      widget.email, passwordController.text);
                  Navigator.pop(context);
                  if (res.statusCode!) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    snackbar(res.message!, context);
                  }
                } else {
                  snackbar('Password not match', context);
                }
              },
              child: Container(
                  width: size.width * 0.95,
                  height: size.width * 0.13,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "Change password",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )),
            ),
            // SizedBox(
            //   height: 100,
            // ),
            // Text(
            //   "Enter new Password",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontFamily: 'bold',
            //     color: Color(0xff9d9d9d),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // AuthEditField(
            //   validator: (e) => e!.isEmpty
            //       ? "Enter the password"
            //       : e.length < 6
            //           ? "Password must be 6 digit length"
            //           : null,
            //   suffix: true,
            //   controller: passwordController,
            //   inputDecoration: authInputDecoration,
            //   hint: 'Password',
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // AuthEditField(
            //   validator: (e) => e!.isEmpty
            //       ? "Enter the confirm password"
            //       : e.length < 6
            //           ? "Confirm password must be 6 digit length"
            //           : null,
            //   suffix: true,
            //   controller: confirmPasswordController,
            //   inputDecoration: authInputDecoration,
            //   hint: 'Confirm Password',
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            // InkWell(
            //   onTap: () async {},
            //   child: Container(
            //       width: size.width * 0.95,
            //       height: size.width * 0.13,
            //       decoration: BoxDecoration(
            //           color: primaryColor,
            //           borderRadius: BorderRadius.circular(5)),
            //       child: Center(
            //         child: Text(
            //           "Submit",
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 16),
            //         ),
            //       )),
            // ),
          ],
        ),
      ),
    );
  }
}
