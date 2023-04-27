import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Constant/InputStyle.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';
import 'package:userapp/Screen/AuthScreens/ForgetPasswordOTPverification.dart';
import 'package:userapp/Screen/CommonWidgets/EditField.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/CommonWidgets/Snackbar.dart';

class ForgetPasswordScreen extends StatefulHookWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String email = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _userProvide = useProvider(userInfoProvider);
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
            Center(
              child: Text(
                "Forget Password?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff173143),
                    letterSpacing: 1,
                    fontFamily: 'bold'),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Retrieve your Password",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, color: Color(0xff9d9d9d), fontFamily: 'bold'),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Form(
              key: _formkey,
              child: EditField(
                controller: emailController,
                validator: (val) {
                  if (val == "" || val == " ") {
                    return "Enter Email Address";
                  }
                },
                onsave: (val) {
                  setState(() {
                    email = val;
                  });
                },
                hint: "Email",
                inputDecoration: regularInputDecoration.copyWith(
                    hintStyle: TextStyle(fontSize: 16, fontFamily: 'bold')),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            InkWell(
              onTap: () async {
                if (_formkey.currentState!.validate()) {
                  _formkey.currentState!.save();

                  poploading(context);
                  ResponseData responseData =
                      await _userProvide.sendForgotPasswordEmail(email);
                  Navigator.pop(context);
                  snackbar(responseData.message!, context);
                  if (responseData.statusCode!) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ForgetPasswordOTPverification(
                                  email: email,
                                )));
                  }
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
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
