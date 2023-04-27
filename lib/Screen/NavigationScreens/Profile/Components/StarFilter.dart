import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';

class StarFilter extends StatefulWidget {
  @override
  _StarFilterState createState() => _StarFilterState();
}

class _StarFilterState extends State<StarFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customButton('1'),
                customButton('2'),
                customButton('3')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customButton('4'),
                customButton('5'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget customButton(String title) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(button_radius),
              border: Border.all(color: thirdColor)),
          height: 50,
          width: size.width / 4,
          child: Center(child: Text(title)),
        ),
      ),
    );
  }
}
