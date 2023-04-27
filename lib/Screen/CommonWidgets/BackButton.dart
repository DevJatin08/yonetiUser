import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      //child :Container(
      //         margin: EdgeInsets.only(top: 10, left: 10),
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Colors.black,
      //         ),
      //         padding: EdgeInsets.all(4),
      //         child: Icon(
      //           Icons.arrow_back,
      //           color: Colors.white,
      //         ),
      //       ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }
}
