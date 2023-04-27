import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Marchant/MarchantDetail.dart';
import 'package:userapp/Model/UI/Month.dart';
import 'package:userapp/Screen/CommonWidgets/Appbars/Appbar.dart';
import 'package:userapp/Screen/CommonWidgets/CustomButton.dart';
import 'package:userapp/Screen/CommonWidgets/Popup.dart';
import 'package:userapp/Screen/NavigationScreens/Order/SwapVerification.dart';

class SwapOrder extends StatefulWidget {
  bool? accept;
  Order? order;
  SwapOrder({this.accept = false, this.order});

  @override
  _SwapOrderState createState() => _SwapOrderState();
}

class _SwapOrderState extends State<SwapOrder> {
  int mins = 0;
  @override
  void initState() {
    // TODO: implement initState
    mins = Duration(microseconds: int.parse(widget.order!.startTime.toString()) + int.parse(widget.order!.endTime.toString()))
        .inMinutes;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _swapBookingProvider = context.read(swapBookingProvider);

    DateTime now = DateTime.now();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppbarWithoutIcon(
              title: 'Swap Request',
              subWidget: RichText(
                text: TextSpan(
                    text: '${now.hour}:${now.minute} | ',
                    style: TextStyle(
                        fontSize: 12,
                        color: cardSubTextColor,
                        fontFamily: 'bold'),
                    children: [
                      TextSpan(
                          text:
                              '${now.day}-${month[now.month - 1]}-${now.year}')
                    ]),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Jack Lee',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'bold'),
                                children: [
                                  TextSpan(
                                      text: ' requested to swap',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: cardSubTextColor,
                                          fontFamily: 'bold'))
                                ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Usercard(),
                          SizedBox(
                            height: 10,
                          ),
                          //Whith this service bellow
                          Text(
                            'Whith this service bellow',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff8991a0)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SwapUserCard(),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buttons(widget.accept! ? 'Accept' : 'Send', () {
                          if (widget.accept!) {
                            customPopUp(context, SwapVerification());
                          }
                          if (widget.accept == false) {
                            _swapBookingProvider.SwapBooking(
                                context: context,
                                swap_user_id:
                                    widget.order!.booking_id.toString(),
                                user_booking_id: "79",
                                swap_user_booking_id:
                                    widget.order!.order_id.toString());
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${_swapBookingProvider}")));
                          }
                        }, primaryColor),
                        SizedBox(
                          width: 10,
                        ),
                        buttons('Cancel', () {}, Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //     child: ListView.builder(
            //         itemCount: 4,
            //         itemBuilder: (context, index) {
            //           return Padding(
            //             padding: EdgeInsets.symmetric(
            //                 vertical: 8, horizontal: size.width * 0.05),
            //             child: Material(
            //               color: Colors.white,
            //               elevation: 1,
            //               borderRadius: BorderRadius.circular(cardRadius),
            //               child: Container(
            //                 height: 70,
            //                 width: size.width,
            //                 decoration: BoxDecoration(
            //                     borderRadius:
            //                         BorderRadius.circular(cardRadius)),
            //                 child: Stack(
            //                   alignment: Alignment.topRight,
            //                   children: [
            //                     Row(
            //                       crossAxisAlignment: CrossAxisAlignment.center,
            //                       children: [
            //                         Container(
            //                           width: 75,
            //                           decoration: BoxDecoration(
            //                             borderRadius: BorderRadius.only(
            //                                 bottomLeft:
            //                                     Radius.circular(cardRadius),
            //                                 topLeft:
            //                                     Radius.circular(cardRadius)),
            //                             color: primaryColor,
            //                           ),
            //                           child: Center(
            //                             child: Column(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment.center,
            //                               children: [
            //                                 Text(
            //                                   '18',
            //                                   maxLines: 1,
            //                                   overflow: TextOverflow.ellipsis,
            //                                   style: TextStyle(
            //                                       fontSize: 23,
            //                                       color: Colors.white,
            //                                       fontFamily: 'bold'),
            //                                 ),
            //                                 Text(
            //                                   'Today',
            //                                   maxLines: 1,
            //                                   overflow: TextOverflow.ellipsis,
            //                                   style: TextStyle(
            //                                       fontSize: 11,
            //                                       color: Colors.white,
            //                                       fontFamily: 'bold'),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                         SizedBox(
            //                           width: 20,
            //                         ),
            //                         Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: [
            //                             Text(
            //                               'Hair Cut - Agha Dostain',
            //                               maxLines: 1,
            //                               overflow: TextOverflow.ellipsis,
            //                               style: TextStyle(
            //                                   fontSize: 13,
            //                                   color: thirdColor,
            //                                   fontFamily: 'bold'),
            //                             ),
            //                             Row(
            //                               children: [
            //                                 Text(
            //                                   '9:00 am - 45min',
            //                                   maxLines: 1,
            //                                   overflow: TextOverflow.ellipsis,
            //                                   style: TextStyle(
            //                                       fontSize: 12,
            //                                       color: cardSubTextColor,
            //                                       fontFamily: 'bold'),
            //                                 ),
            //                                 SizedBox(
            //                                   width: 20,
            //                                 ),
            //                               ],
            //                             )
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           );
            //         }))
          ],
        ),
      ),
    );
  }

  Widget buttons(String text, VoidCallback ontap, Color color) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: ontap,
      child: Container(
        width: size.width * 0.7 / 2,
        height: 30,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget Usercard() {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(cardRadius),
      child: Container(
        height: 70,
        width: size.width,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(cardRadius)),
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
                        bottomLeft: Radius.circular(cardRadius),
                        topLeft: Radius.circular(cardRadius)),
                    color: primaryColor,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "32",
                          // '${widget.order!.date!.split(',')[1]}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                              fontFamily: 'bold'),
                        ),
                        Text(
                          'Jul',
                          // '${widget.order!.date!.split(',')[0]}',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hair Cut - Agha Dostain',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 13, color: thirdColor, fontFamily: 'bold'),
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
          ],
        ),
      ),
    );
  }

  Widget SwapUserCard() {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(cardRadius),
      child: Container(
        height: 70,
        width: size.width,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(cardRadius)),
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
                        bottomLeft: Radius.circular(cardRadius),
                        topLeft: Radius.circular(cardRadius)),
                    color: primaryColor,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.order!.date!.split(',')[1]}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                              fontFamily: 'bold'),
                        ),
                        Text(
                          '${widget.order!.date!.split(',')[0]}',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.order!.orderDetails.toString()}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 13, color: thirdColor, fontFamily: 'bold'),
                    ),
                    Row(
                      children: [
                        Text(
                          '9:00 am - ${mins}min',
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
          ],
        ),
      ),
    );
  }

}
