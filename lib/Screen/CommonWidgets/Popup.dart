import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

customPopUp(BuildContext context, Widget widget) {
  final size = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (
        context,
      ) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Material(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: widget),
          ),
        );
      });
}
