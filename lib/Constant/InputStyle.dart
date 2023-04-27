import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';

InputDecoration transparentInputDecoration = InputDecoration(
    border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(8)),
    enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent)),
    disabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent)),
    focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent)),
    isCollapsed: true,
    counterText: "");

InputDecoration regularInputDecoration = InputDecoration(
  isCollapsed: true,
  contentPadding: EdgeInsets.symmetric(vertical: 10),
  prefixIconConstraints: BoxConstraints(minHeight: 60, minWidth: 60),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xffd7d7d7), width: 1.5)),
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 3)),
);
InputDecoration underLineInputDecoration = InputDecoration(
    border: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xfff1f1f1), width: 2)),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xfff1f1f1), width: 2)),
    disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xfff1f1f1), width: 2)),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2)),
    counterText: "");
InputDecoration dropDownInputDecoration = InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryColor, width: 0.5)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryColor, width: 0.5)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryColor, width: 0.5)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryColor, width: 0.5)),
    counterText: "");
InputDecoration authInputDecoration = InputDecoration(
  isCollapsed: false,
  labelText: 'asd',
  contentPadding: EdgeInsets.all(0),
  labelStyle: TextStyle(fontSize: 14),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xffd7d7d7), width: 1.5)),
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1.5)),
);
