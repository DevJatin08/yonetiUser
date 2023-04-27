import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';

poploading(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
            child: CircularProgressIndicator(
          color: primaryColor,
        ));
      });
}

class LoadingWidget extends StatelessWidget {
  Color? color;
  LoadingWidget({this.color = primaryColor});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(   
      color: color,
    ));
  }
}
