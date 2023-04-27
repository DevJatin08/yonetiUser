import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';

class AppbarWithoutIcon extends StatefulWidget {
  String title;
  Widget? subWidget;
  AppbarWithoutIcon({required this.title, this.subWidget = const SizedBox()});

  @override
  _AppbarWithoutIconState createState() => _AppbarWithoutIconState();
}

class _AppbarWithoutIconState extends State<AppbarWithoutIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontFamily: 'bold', fontSize: 20, color: thirdColor),
                  ),
                  widget.subWidget!
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
