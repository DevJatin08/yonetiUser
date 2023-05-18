import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Constant/InputStyle.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/CommonWidgets/Snackbar.dart';

import 'NewPassword.dart';

class ForgetPasswordOTPverification extends ConsumerStatefulWidget {
  String email;
  ForgetPasswordOTPverification({required this.email, Key? key}) : super(key: key);

  @override
  _ForgetPasswordOTPverification createState() => _ForgetPasswordOTPverification();
}

class _ForgetPasswordOTPverification extends ConsumerState<ForgetPasswordOTPverification> {
  List<FocusNode> focusList = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  int filledBox = -1;
  String otp = '';
  @override
  Widget build(BuildContext context ) {
    final _userProvider = ref.watch(userInfoProvider);
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
            Text(
              "Enter your OTP code here",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'bold',
                color: Color(0xff9d9d9d),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: size.width * 0.13,
                  width: size.width * 0.6,
                  child: ListView.builder(
                      itemExtent: size.width * 0.6 / 4,
                      itemCount: focusList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.circle,
                            color: filledBox < index ? Color(0xff9d9d9d) : Colors.transparent,
                            size: 14,
                          ),
                        );
                      }),
                ),
                Container(
                  height: size.width * 0.13,
                  width: size.width * 0.6,
                  child: ListView.builder(
                      itemCount: focusList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                          child: Center(
                            child: Container(
                              width: size.width * 0.13,
                              child: TextField(
                                style:
                                    TextStyle(fontSize: size.height * 0.03, color: editFeildText),
                                maxLength: 1,

                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                focusNode: focusList[index],

                                onChanged: (v) {
                                  if (v.length > 0) {
                                    if (index < 3) {
                                      FocusScope.of(context).requestFocus(focusList[index + 1]);
                                    }
                                    if (index <= 3) {
                                      otp = otp + v;
                                    }
                                  } else {
                                    if (index > 0) {
                                      print('enter');
                                      otp = otp.substring(0, index - 1);
                                      FocusScope.of(context).requestFocus(focusList[index - 1]);
                                    }
                                  }
                                  print(index);
                                  filledBox = index;

                                  setState(() {});
                                },
                                decoration: transparentInputDecoration.copyWith(
                                    isCollapsed: false, contentPadding: EdgeInsets.all(0)),

                                // decoration:
                                //     verificationDecoration(inputBorderColor),
                                textInputAction: TextInputAction.next, // Moves focus to next.
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () async {
                if (otp.length == 4) {
                  poploading(context);
                  final res =
                      await _userProvider.forgetPassword_otp_verification(widget.email, otp);
                  Navigator.pop(context);
                  if (res.statusCode!) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => NewPassword(
                                  email: widget.email,
                                )));
                  } else {
                    snackbar(res.message!, context);
                  }
                }
              },
              child: Container(
                  width: size.width * 0.95,
                  height: size.width * 0.13,
                  decoration:
                      BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "Verify",
                      style:
                          TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
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
