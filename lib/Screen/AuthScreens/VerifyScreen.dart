import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Constant/InputStyle.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/CommonWidgets/Snackbar.dart';
import 'package:userapp/Screen/NavigationScreens/BaseScreen.dart';
import 'package:userapp/main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyScreen extends StatefulHookWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  List<FocusNode> focusList = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  TextEditingController controller = TextEditingController();
  int filledBox = -1;
  String otp = '';

  @override
  Widget build(BuildContext context) {
    final userProvider = useProvider(userInfoProvider);
    final notifications = useProvider(notificationProvider);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * mainPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Center(
              child: Text(
                "Verify your Mobile",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff173143),
                  fontFamily: 'bold',
                  letterSpacing: 1,
                ),
              ),
            ),
            SizedBox(
              height: 5,
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
                // Container(
                //   height: size.width * 0.13,
                //   width: size.width * 0.6,
                //   child: ListView.builder(
                //       itemExtent: size.width * 0.6 / 4,
                //       itemCount: focusList.length,
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (context, index) {
                //         return Container(
                //           width: 20,
                //           height: 20,
                //           decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //           ),
                //           child: Icon(
                //             Icons.circle,
                //             color: filledBox < index ? Color(0xff9d9d9d) : Colors.transparent,
                //             size: 14,
                //           ),
                //         );
                //       }),
                // ),
                // Container(
                //   height: size.width * 0.13,
                //   width: size.width * 0.6,
                //   child: ListView.builder(
                //       itemCount: focusList.length,
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (context, index) {
                //         return Padding(
                //           padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                //           child: Center(
                //             child: Container(
                //               width: size.width * 0.13,
                //               child: TextField(
                //                 style:
                //                     TextStyle(fontSize: size.height * 0.03, color: editFeildText),
                //                 maxLength: 1,

                //                 textAlign: TextAlign.center,
                //                 keyboardType: TextInputType.number,
                //                 focusNode: focusList[index],

                //                 onChanged: (v) {
                //                   if (v.length > 0) {
                //                     if (index < 3) {
                //                       FocusScope.of(context).requestFocus(focusList[index + 1]);
                //                     }
                //                     if (index <= 3) {
                //                       otp = otp + v;
                //                     }
                //                   } else {
                //                     if (index > 0) {
                //                       print('enter');
                //                       otp = otp.substring(0, index - 1);
                //                       FocusScope.of(context).requestFocus(focusList[index - 1]);
                //                     }
                //                   }
                //                   print(index);
                //                   filledBox = index;

                //                   setState(() {});
                //                 },
                //                 decoration: transparentInputDecoration.copyWith(
                //                     isCollapsed: false, contentPadding: EdgeInsets.all(0)),

                //                 // decoration:
                //                 //     verificationDecoration(inputBorderColor),
                //                 textInputAction: TextInputAction.next, // Moves focus to next.
                //               ),
                //             ),
                //           ),
                //         );
                //       }),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,

                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      inactiveFillColor: Colors.white,
                      selectedColor: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    // backgroundColor: Colors.blue.shade50,
                    enableActiveFill: false,
                    // errorAnimationController: controller,
                    controller: controller,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        otp = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            InkWell(
              onTap: () async {
                if (otp.length == 4) {
                  poploading(context);
                  final res = await userProvider.verifyOTP(otp);
                  Navigator.pop(context);
                  if (res.statusCode!) {
                    Navigator.pop(context);
                    notifications.sendNotification(
                        deviceId: fcmToken.toString());
                    log(deviceId);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => BaseHomeWidget()));
                  } else {
                    snackbar(res.message!, context);
                  }
                }

                 Navigator.push(context,
                        MaterialPageRoute(builder: (_) => BaseHomeWidget()));
                // TODO: after testing remove this

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (_) => BaseHomeWidget()));
              },
              child: Container(
                  width: size.width * 0.95,
                  height: size.width * 0.13,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "Verify Now",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
