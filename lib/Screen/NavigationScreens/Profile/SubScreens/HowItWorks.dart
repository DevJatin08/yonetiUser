import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';


class HowItWorks extends StatefulWidget {
  HowItWorks({Key? key}) : super(key: key);

  @override
  _HowItWorksState createState() => _HowItWorksState();
}

class _HowItWorksState extends State<HowItWorks> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xffeaeaea),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
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
                    SizedBox(
                      width: size.width * 0.25,
                    ),
                    Center(
                      child: Text(
                        'How it works!',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'bold',
                            color: Color(0xff9d9d9d)),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Image.network(
                  'https://i.pinimg.com/originals/15/d4/90/15d4903ffd54f3ad76007ffae8722fc5.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
