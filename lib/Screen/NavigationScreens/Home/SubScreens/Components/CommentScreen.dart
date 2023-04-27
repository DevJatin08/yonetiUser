import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/InputStyle.dart';
import 'package:userapp/Screen/CommonWidgets/CustomButton.dart';
import 'package:userapp/Screen/CommonWidgets/EditField.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Enter your comment',
            style:
                TextStyle(fontFamily: 'bold', fontSize: 16, color: thirdColor),
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: EditField(
                  controller: controller,
                  inputDecoration:
                      regularInputDecoration.copyWith(hintText: 'Comment'))),
          SizedBox(height: 18),
          CustomButton(text: 'Submit', voidCallback: () {})
        ],
      ),
    );
  }
}
