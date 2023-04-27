import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/InputStyle.dart';

class SwapVerification extends StatefulWidget {
  SwapVerification({Key? key}) : super(key: key);

  @override
  _SwapVerificationState createState() => _SwapVerificationState();
}

class _SwapVerificationState extends State<SwapVerification> {
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cardRadius),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "OTP verification",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'bold',
                  // color: Color(0xff9d9d9d),
                  color: primaryColor),
            ),
            SizedBox(height: 20),
            Center(
              child: Stack(
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
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Icon(
                            Icons.circle,
                            color: filledBox < index ? Color(0xff9d9d9d) : Colors.transparent,
                            size: 14,
                          ),
                        );
                      },
                    ),
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
                                  style: TextStyle(fontSize: size.height * 0.03, color: editFeildText),
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
                                  decoration: transparentInputDecoration.copyWith(isCollapsed: false, contentPadding: EdgeInsets.all(0)),

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
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: size.width * 0.95,
                height: size.width * 0.13,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    "Verify Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
