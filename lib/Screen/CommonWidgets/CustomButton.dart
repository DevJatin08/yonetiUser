import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';

class CustomButton extends StatelessWidget {
  String text;
  VoidCallback voidCallback;
  //double width;
  Color? color;
  // double? height;
  double? radius;
  double? fontSize;
  FontWeight? fontWeight;
  String? family;
  Color? textColor;

  CustomButton(
      {required this.text,
      required this.voidCallback,
      this.color = buttonColor,
      // this.height = 15.0,
      this.radius = button_radius,
      // this.width = 0.8,
      this.family = 'bold',
      this.fontWeight = FontWeight.normal,
      this.fontSize,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: InkWell(
        onTap: voidCallback,
        child: Container(
          // width: size.width * width,
          width: size.width * buttonWidth,
          height: size.width * 0.13,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(radius!)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontFamily: family,
                  fontWeight: fontWeight),
            ),
          ),
        ),
      ),
    );
  }
}
