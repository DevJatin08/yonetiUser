import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Screen/CommonWidgets/Appbars/Appbar.dart';
import 'package:userapp/Screen/CommonWidgets/Appbars/AppbarWithIcons.dart';

class SwapOrderRequest extends StatefulWidget {
  SwapOrderRequest({Key? key}) : super(key: key);

  @override
  _SwapOrderRequestState createState() => _SwapOrderRequestState();
}

class _SwapOrderRequestState extends State<SwapOrderRequest> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppbarWithoutIcon(
              title: 'Client Name',
              subWidget: Text(
                '65 Bookings',
                style: TextStyle(
                    fontSize: 12, color: cardSubTextColor, fontFamily: 'bold'),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8, horizontal: size.width * 0.05),
                        child: Material(
                          color: Colors.white,
                          elevation: 1,
                          borderRadius: BorderRadius.circular(cardRadius),
                          child: Container(
                            height: 70,
                            width: size.width,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(cardRadius)),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 75,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft:
                                                Radius.circular(cardRadius),
                                            topLeft:
                                                Radius.circular(cardRadius)),
                                        color: primaryColor,
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '18',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  color: Colors.white,
                                                  fontFamily: 'bold'),
                                            ),
                                            Text(
                                              'Today',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white,
                                                  fontFamily: 'bold'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hair Cut - Agha Dostain',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: thirdColor,
                                              fontFamily: 'bold'),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '9:00 am - 45min',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: cardSubTextColor,
                                                  fontFamily: 'bold'),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 100),
                                  width: 20,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(100),
                                          bottomLeft: Radius.circular(100))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
