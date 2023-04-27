import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Screen/CommonWidgets/BackButton.dart';

class BackGroundScreen extends StatefulWidget {
  String? avatar;
  BackGroundScreen({Key? key, this.avatar}) : super(key: key);

  @override
  _BackGroundScreenState createState() => _BackGroundScreenState();
}

class _BackGroundScreenState extends State<BackGroundScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.avatar.toString()),
                    fit: BoxFit.fill)),
          ),
          Align(alignment: Alignment.topLeft, child: CustomBackButton()),
        ],
      ),
    );
  }
}
