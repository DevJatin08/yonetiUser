import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Model/Marchant/MarchantDetail.dart';

class SwipeCard extends StatefulWidget {
  Order order;

  SwipeCard({
    required this.order,
  });

  @override
  _SwipeCardState createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  bool swipeOpen = false;
  DateTime now = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(DateTime.fromMillisecondsSinceEpoch(
    //     int.parse(widget.order.startTime!)));
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: swipeOpen ? 0 : 20),
      child: Center(
        child: GestureDetector(
          // onHorizontalDragUpdate: (v) {
          //   if (v.delta.dx.isNegative) {
          //     setState(() {
          //       swipeOpen = true;
          //     });
          //   } else {
          //     setState(() {
          //       swipeOpen = false;
          //     });
          //   }
          // },
          child: Row(
            children: [
              Expanded(
                child: Material(
                  color: Colors.white,
                  elevation: 0.8,
                  borderRadius: BorderRadius.circular(cardRadius),
                  child: Container(
                    height: 70,
                    width: size.width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(cardRadius)),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(cardRadius), topLeft: Radius.circular(cardRadius)),
                                color: primaryColor,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.order.date!.split(',')[1],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 23, color: Colors.white, fontFamily: 'bold'),
                                    ),
                                    Text(
                                      widget.order.date!.split(',')[0],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'bold'),
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
                                Row(
                                  children: [
                                    Container(
                                      width: size.width * 0.50,
                                      child: Text(
                                        widget.order.orderDetails.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 13, color: thirdColor, fontFamily: 'bold'),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '45 min',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 12, color: cardSubTextColor, fontFamily: 'bold'),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: widget.order.orderStatus == 'active'
                                            ? Color(0xff44c658)
                                            : widget.order.orderStatus == 'pending'
                                                ? Colors.yellow
                                                : primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      widget.order.orderStatus!,
                                      style: TextStyle(fontSize: 12, color: cardSubTextColor, fontFamily: 'bold'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        // AnimatedContainer(
                        //     duration: Duration(milliseconds: 100),
                        //     width: swipeOpen ? 200 : 30,
                        //     height: 70,
                        //     decoration: BoxDecoration(
                        //         color: primaryColor,
                        //         borderRadius: BorderRadius.only(
                        //             topLeft: Radius.circular(50),
                        //             bottomLeft: Radius.circular(50))),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         GestureDetector(
                        //           onTap: () {
                        //             // setState(() {
                        //             //   swipeOpen = !swipeOpen;
                        //             // });
                        //           },
                        //           child: Padding(
                        //             padding: const EdgeInsets.only(left: 3),
                        //             child: Icon(
                        //               swipeOpen
                        //                   ? Icons.keyboard_arrow_right
                        //                   : Icons.keyboard_arrow_left,
                        //               color: Colors.white,
                        //             ),
                        //           ),
                        //         ),
                        //         swipeOpen
                        //             ? Expanded(
                        //                 child: InkWell(
                        //                   onTap: () {
                        //                     widget.onchaged('sad');
                        //                     Navigator.push(
                        //                         context,
                        //                         MaterialPageRoute(
                        //                             builder: (_) => SwapOrder()));
                        //                   },
                        //                   child: Container(
                        //                     width: 150,
                        //                     height: 40,
                        //                     decoration: BoxDecoration(
                        //                         borderRadius:
                        //                             BorderRadius.circular(20),
                        //                         color: Colors.white),
                        //                     child: Center(
                        //                       child: Text(
                        //                         'Swap Booking',
                        //                         style: TextStyle(
                        //                             color: primaryColor,
                        //                             fontSize: 15,
                        //                             fontFamily: 'bold'),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               )
                        //             : SizedBox(),
                        //       ],
                        //     )),
                      ],
                    ),
                  ),
                ),
              ),
              // swipeOpen
              //     ? IconButton(
              //         onPressed: () {
              //           Navigator.push(context,
              //               MaterialPageRoute(builder: (_) => SwapOrder(order: widget.order,)));
              //         },
              //         icon: Icon(
              //           Icons.sync,
              //           color: cardSubTextColor,
              //         ))
              //     : Container()
            ],
          ),
        ),
      ),
    );
  }
}
