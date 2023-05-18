import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/BrandDetails.dart';

class ReversationPopUp extends HookConsumerWidget {
  const ReversationPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final _marchantProvider = ref.watch(marchantProvider);
    return Center(
      child: Container(
        height: 200,
        width: 250,
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(cardRadius),
            color: Colors.transparent,
            child: SingleChildScrollView(
                child: Container(
              width: size.width,
              // height: size.height * 0.85,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(cardRadius)),
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/boxTick.png',
                        width: 35,
                        height: 35,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Your Booking is Scheduled',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'bold',
                          color: Color(0xff121212),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Go to ',
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                              text: 'Bookings',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'bold',
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'bold',
                            color: Color(0xff121212),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
