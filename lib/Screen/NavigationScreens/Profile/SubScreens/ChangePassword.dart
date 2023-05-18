import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Constant/InputStyle.dart';
import 'package:userapp/Screen/CommonWidgets/CustomButton.dart';
import 'package:userapp/Screen/CommonWidgets/EditField.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/CommonWidgets/Snackbar.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/SubScreens/Confirmation.dart';

import '../../../../main.dart';

class ChangePassword extends ConsumerStatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  List<FocusNode> focusList = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  int filledBox = -1;

  String otp = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _userProvide = ref.watch(userInfoProvider);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Change Password",
                style: TextStyle(fontSize: 18, fontFamily: 'bold'),
              ),
            ),
            Divider(
              color: Color(0xfff2f2f3),
              thickness: 3,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  EditableTextField(
                    controller: oldPassword,
                    label: 'Old Password',
                    suffix: false,
                    action: TextInputAction.next,
                    inputDecoration: transparentInputDecoration,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EditableTextField(
                    controller: newPassword,
                    label: 'New Password',
                    suffix: false,
                    action: TextInputAction.done,
                    inputDecoration: transparentInputDecoration.copyWith(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: 'Update',
                      voidCallback: () async {
                        poploading(context);
                        await _userProvide.sendOTP();
                        Navigator.pop(context);
                      },
                      color: primaryColor),
                  SizedBox(
                    height: 20,
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
                                      TextStyle(fontSize: size.height * 0.03, color: customField),
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
                                        otp = otp.substring(0, index - 1);
                                        FocusScope.of(context).requestFocus(focusList[index - 1]);
                                      }
                                    }
                                    print(index);
                                    filledBox = index;

                                    setState(() {});
                                  },
                                  decoration: transparentInputDecoration.copyWith(
                                      filled: true,
                                      fillColor: Color(0xfff1f7f7),
                                      isCollapsed: false,
                                      contentPadding: EdgeInsets.all(0)),

                                  // decoration:
                                  //     verificationDecoration(inputBorderColor),
                                  textInputAction: TextInputAction.next, // Moves focus to next.
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text(
                    "Enter your OTP code here",
                    style: TextStyle(fontSize: 16, color: Color(0xff9d9d9d), fontFamily: 'bold'),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: 'Confirm',
                      voidCallback: () async {
                        if (otp.length == 4) {
                          poploading(context);
                          final res = await _userProvide.chnagePasswordOTPVerify(otp);
                          log("$res", name: "Update Password");
                          if (res.statusCode!) {
                            final res_password = await _userProvide.chnagePassword(
                                newPassword.text, oldPassword.text);
                            if (res_password.statusCode == true) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              await apiCall.sendNotification(
                                title: "Password Updated",
                                body: "Your Password is Updated",
                                to: fcmToken!,
                              );
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ConfirmationScreen(
                                      color: Color(0xff4b6057),
                                      icon: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                      name: 'Your Password Has Been \nSuccessfully Updated',
                                    );
                                  });
                            } else {
                              snackbar(res_password.message!, context);
                            }
                          } else {
                            snackbar(res.message!, context);
                          }
                        }

                        // customPopUp(context, ConfirmationScreen());
                      },
                      color: primaryColor),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
