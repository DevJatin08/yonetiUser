import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Order/ActiveOrder.dart';
import 'package:userapp/Model/Order/OrderDetails.dart';
import 'package:userapp/Screen/CommonWidgets/Appbars/Appbar.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/CommonWidgets/Popup.dart';
import 'package:userapp/Screen/NavigationScreens/Home/Chat/Chat.dart';
import 'package:userapp/Screen/NavigationScreens/Home/Homepage.dart';
import 'package:userapp/Screen/NavigationScreens/Order/SwapVerification.dart';

import '../../../Model/Marchant/MarchantDetail.dart';

class OrderDetail extends StatefulHookWidget {
  String? Order_id;
  Booking booking;

  OrderDetail({Key? key, this.Order_id, required this.booking}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  int mins = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    loadData();
    mins = Duration(seconds: int.parse(1000.toString()) + int.parse(1000.toString())).inMinutes;
  }

  bool loader = true;

  loadData() async {
    final _marchantProvider = context.read(marchantProvider);
    final _orderProvider = context.read(orderProvider);
    //  await context.read(marchantProvider).getMarchantDetail(_orderProvider.orderDetailsEmpty.marchantId);
    await _orderProvider.orderDetails(order_id: widget.Order_id.toString());
    await context.read(marchantProvider).getMarchantDetail(_orderProvider.orderDetailsEmpty.marchantId);
    if (_marchantProvider.marchantDetails.orders![0] != null) _order = _marchantProvider.marchantDetails.orders![0];
    setState(() {
      loader = false;
    });
  }

  DateTime now = DateTime.now();
  late Order _order;
  bool accept = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _orderProvider = useProvider(orderProvider);
    final _marchantProvider = context.read(marchantProvider);
    final _swapBookingProvider = context.read(swapBookingProvider);

    _orderProvider.orderDetails(order_id: widget.Order_id.toString());

    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: loader
          ? LoadingWidget()
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: AppbarWithoutIcon(
                    title: 'Swap Request',
                    subWidget: RichText(
                      text: TextSpan(
                        text: '${now.hour}:${now.minute} | ',
                        style: TextStyle(
                          fontSize: 12,
                          color: cardSubTextColor,
                          fontFamily: 'bold',
                        ),
                        children: [
                          TextSpan(text: '${now.day}-${month[now.month - 1]}-${now.year}'),
                        ],
                      ),
                    ),
                  ),
                ),
                FutureBuilder<OrderDetails>(
                  future: _orderProvider.orderDetails(order_id: widget.Order_id.toString()),
                  builder: (context, snapshot) {
                    log(jsonEncode(snapshot.data), name: "Swap Data");
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: '${_orderProvider.orderDetailsEmpty.userName}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: 'bold',
                                ),
                                children: [
                                  TextSpan(
                                    text: ' requested to swap',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: cardSubTextColor,
                                      fontFamily: 'bold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),

                            Usercard(_orderProvider.orderDetailsEmpty),

                            SizedBox(height: 10),
                            //Whith this service bellow
                            Text(
                              'With this service below',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff8991a0),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      content: Container(
                                        height: _marchantProvider.marchantDetails.orders!.length * 77,
                                        width: MediaQuery.of(context).size.width,
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          itemCount: _marchantProvider.marchantDetails.orders!.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _order = _marchantProvider.marchantDetails.orders![index];
                                                  });
                                                  log(_order.date.toString());
                                                  Navigator.of(context).pop();
                                                },
                                                child: SwapUserCard(_marchantProvider.marchantDetails.orders![index]));
                                          },
                                          separatorBuilder: (BuildContext context, int index) {
                                            return SizedBox(
                                              height: 8,
                                            );
                                          },
                                        ),
                                      ),
                                    );

                                    // StatefulBuilder(
                                    //     builder: (context, setState) {
                                    //   return AlertDialog(
                                    //     shape: RoundedRectangleBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(
                                    //                 20)),
                                    //     content: Container(
                                    //       height: _marchantProvider
                                    //               .marchantDetails
                                    //               .orders!
                                    //               .length *
                                    //           77,
                                    //       width: MediaQuery.of(context)
                                    //           .size
                                    //           .width,
                                    //       child: ListView.separated(
                                    //         itemCount: _marchantProvider
                                    //             .marchantDetails
                                    //             .orders!
                                    //             .length,
                                    //         itemBuilder:
                                    //             (context, index) {
                                    //           return GestureDetector(
                                    //               onTap: () {
                                    //                 setState(() {
                                    //                   _order = _marchantProvider
                                    //                       .marchantDetails
                                    //                       .orders![index];
                                    //                 });
                                    //                 log(_order.date
                                    //                     .toString());
                                    //                 Navigator.of(context)
                                    //                     .pop();
                                    //               },
                                    //               child: SwapUserCard(
                                    //                   _marchantProvider
                                    //                       .marchantDetails
                                    //                       .orders![index]));
                                    //         },
                                    //         separatorBuilder:
                                    //             (BuildContext context,
                                    //                 int index) {
                                    //           return SizedBox(
                                    //             height: 8,
                                    //           );
                                    //         },
                                    //       ),
                                    //     ),
                                    //   );
                                    // });
                                  },
                                );
                              },
                              child: SwapUserCard(_order),
                            ),
                            // Container(
                            //   height: 172,
                            //   child: SingleChildScrollView(
                            //     child: ExpansionTile(tilePadding: EdgeInsets.zero,
                            //       title: SwapUserCard(
                            //           _order),
                            //       children: _marchantProvider.marchantDetails.orders!
                            //           .map((e) => SwapUserCard(e))
                            //           .toList(),
                            //     ),
                            //   ),
                            // )
                            // DropdownButton(items: _marchantProvider.marchantDetails.orders!.map((e) => DropdownMenuItem(child: SwapUserCard(e),value: e.booking_id,)).toList(), onChanged: (value){})
                            SizedBox(height: size.height * 0.05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buttons(
                                  accept ? 'Accept' : 'Send',
                                  () {
                                    if (accept) {
                                      customPopUp(
                                        context,
                                        SwapVerification(),
                                      );
                                    }
                                    if (accept == false) {
                                      _swapBookingProvider.SwapBooking(
                                          context: context,
                                          swap_user_id: _order.booking_id.toString(),
                                          user_booking_id: _orderProvider.orderDetailsEmpty.orderId,
                                          swap_user_booking_id: _order.order_id.toString());
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${_swapBookingProvider.snack}")));
                                    }
                                  },
                                  primaryColor,
                                ),
                                SizedBox(width: 10),
                                buttons(
                                  'Cancel',
                                  () => Navigator.pop(context),
                                  Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return AspectRatio(aspectRatio: 12 / 9, child: Center(child: LoadingWidget()));
                  },
                ),
              ],
            ),
    );
  }

  Widget Usercard(OrderDetails orderDetails) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(cardRadius),
      child: Container(
        // height: 70,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        alignment: Alignment.topRight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(cardRadius),
                  topLeft: Radius.circular(cardRadius),
                ),
                color: primaryColor,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // "32",
                      '${orderDetails.orderDate.split('-').last}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontFamily: 'bold',
                      ),
                    ),
                    Text(
                      // 'Jul',
                      '${setMonth(int.parse(orderDetails.orderDate.split('-')[1]))}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontFamily: 'bold',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // 'Hair Cut - Agha Dostain',
                  '${orderDetails.orderDetails[0].serviceDetails} - ${orderDetails.userName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: thirdColor,
                    fontFamily: 'bold',
                  ),
                ),
                Text(
                  // '9:00 am - 45min',
                  '${orderDetails.startTime}  - ${orderDetails.orderDetails[0].serviceTime}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: cardSubTextColor,
                    fontFamily: 'bold',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget SwapUserCard(Order order) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(cardRadius),
      child: Container(
        height: 70,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
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
                      topLeft: Radius.circular(cardRadius),
                    ),
                    color: primaryColor,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          // '21',
                          '${order.bookingDate!.split('-').last}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontFamily: 'bold',
                          ),
                        ),
                        Text(
                          // 'jul',
                          '${setMonth(int.parse(order.bookingDate!.split('-')[1]))}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontFamily: 'bold',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // 'sdgdfgd',
                      '${order.orderDetails.toString()}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: thirdColor,
                        fontFamily: 'bold',
                      ),
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
                            fontFamily: 'bold',
                          ),
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

  Widget buttons(String text, VoidCallback ontap, Color color) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: ontap,
      child: Container(
        width: size.width * 0.7 / 2,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class PastOrderDetails extends StatefulWidget {
  final String? Order_id;

  const PastOrderDetails({Key? key, this.Order_id}) : super(key: key);

  @override
  State<PastOrderDetails> createState() => _PastOrderDetailsState();
}

class _PastOrderDetailsState extends State<PastOrderDetails> {
  TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _orderProvider = context.read(orderProvider);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: FutureBuilder<OrderDetails>(
        future: _orderProvider.orderDetails(order_id: widget.Order_id.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            log(jsonEncode(data), name: "Order Details");
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      data!.userPic.isNotEmpty
                          ? CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(data.userPic),
                            )
                          : CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey.withOpacity(0.2),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.userName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: primaryColor,
                                fontFamily: 'bold',
                              ),
                            ),
                            Text(
                              "${data.userEmail}",
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 15,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${data.marchantRating}",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.yellow,
                              fontFamily: 'bold',
                            ),
                          ),
                          GestureDetector(
                            onTap: () => showRatingDialogue(
                              merchantId: data.marchantId,
                              orderId: data.orderId,
                            ),
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height: 20,
                                      child: Row(
                                        children: [
                                          ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: int.parse(
                                                data.marchantRating.toStringAsFixed(0),
                                              ),
                                              itemBuilder: (context, subindex) {
                                                return Icon(
                                                  Icons.star_outline,
                                                  color: Colors.yellow,
                                                );
                                              }),
                                          ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: 5 -
                                                int.parse(
                                                  data.marchantRating.toStringAsFixed(0),
                                                ),
                                            itemBuilder: (context, subindex) {
                                              return Icon(
                                                Icons.star_outline,
                                                color: Colors.grey,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "EMAIL",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              '${data.userEmail}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "PHONE",
                              style: TextStyle(fontSize: 14, color: primaryColor, letterSpacing: 1),
                            ),
                            Text(
                              '${data.phoneNum}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "LOCATION",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 14,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    '${data.userAddress}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      height: 1.5,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "DATE & TIME",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 14,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    '${data.date}',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1.5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '${data.startTime} - ${data.endTime}',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  color: primaryColor,
                  height: 0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SERVICES LIST",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'bold',
                          color: primaryColor,
                          letterSpacing: 1,
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 30,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            '${data.orderDetails.length}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 90,
                  child: ListView.builder(
                      itemCount: data.orderDetails.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${data.orderDetails[index].serviceDetails}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontFamily: 'bold',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${data.orderDetails[index].servicePrice}',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                      fontFamily: 'bold',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${data.date}",
                                      style: TextStyle(
                                        height: 1.5,
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${data.orderDetails[index].serviceTime}",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      height: 1.5,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                ),
// Container(
//   margin: EdgeInsets.symmetric(
//     horizontal: 20,
//   ),
//   child: Row(
//     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Smoothie Hair Cut Special",
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: primaryColor,
//                 fontFamily: 'bold',
//               ),
//             ),
//             Text(
//               "06/03/2018",
//               style: TextStyle(
//                 height: 1.5,
//                 fontSize: 14,
//                 color: primaryColor,
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Text(
//               "Smoothie Hair Cut Special",
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: primaryColor,
//                 fontFamily: 'bold',
//               ),
//             ),
//             Text(
//               "06/03/2018",
//               style: TextStyle(
//                 height: 1.5,
//                 fontSize: 14,
//                 color: primaryColor,
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Text(
//               "Smoothie Hair Cut Special",
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: primaryColor,
//                 fontFamily: 'bold',
//               ),
//             ),
//             Text(
//               "06/03/2018",
//               style: TextStyle(
//                 height: 1.5,
//                 fontSize: 14,
//                 color: primaryColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//       SizedBox(
//         width: 20,
//       ),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(
//             "\$28",
//             textAlign: TextAlign.end,
//             style: TextStyle(
//               fontSize: 14,
//               color: primaryColor,
//               fontFamily: 'bold',
//             ),
//           ),
//           Text(
//             "15min",
//             textAlign: TextAlign.end,
//             style: TextStyle(
//               height: 1.5,
//               fontSize: 14,
//               color: primaryColor,
//             ),
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Text(
//             "\$12",
//             textAlign: TextAlign.end,
//             style: TextStyle(
//               fontSize: 14,
//               color: primaryColor,
//               fontFamily: 'bold',
//             ),
//           ),
//           Text(
//             "15min",
//             textAlign: TextAlign.end,
//             style: TextStyle(
//               height: 1.5,
//               fontSize: 14,
//               color: primaryColor,
//             ),
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Text(
//             "\$10",
//             textAlign: TextAlign.end,
//             style: TextStyle(
//               fontSize: 14,
//               color: primaryColor,
//               fontFamily: 'bold',
//             ),
//           ),
//           Text(
//             "15min",
//             textAlign: TextAlign.end,
//             style: TextStyle(
//               height: 1.5,
//               fontSize: 14,
//               color: primaryColor,
//             ),
//           ),
//         ],
//       ),
//     ],
//   ),
// ),
                SizedBox(height: 20)
              ],
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return LoadingWidget();
        },
      ),
    );
  }

  showRatingDialogue({
    required String orderId,
    required String merchantId,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        ValueNotifier<double> orderRating = ValueNotifier(0.0);
        final size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Center(
            child: Text("Rating & Review"),
          ),
          titlePadding: EdgeInsets.only(top: 20),
          titleTextStyle: TextStyle(
            fontSize: size.width * 0.06,
            color: Colors.black,
            fontFamily: 'bold',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                minRating: 0,
                maxRating: 5,
                initialRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  orderRating.value = rating;
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: size.width,
                child: TextField(
                  controller: feedbackController,
                  textAlignVertical: TextAlignVertical.center,
                  showCursor: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.grey.withOpacity(0.2),
                    filled: true,
                    hintText: "Enter your feedback...",
                  ),
                ),
              ),
              // Baseline(
              //   baseline: size.height * -0.32,
              //   baselineType: TextBaseline.alphabetic,
              //   child: Image.asset(
              //     "assets/rating.png",
              //     height: size.height * 0.18,
              //     width: size.width * 0.25,
              //   ),
              // ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          insetPadding: EdgeInsets.symmetric(horizontal: 40),
          contentPadding: EdgeInsets.all(20),
          actionsPadding: EdgeInsets.only(bottom: 20),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Dismiss"),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
                foregroundColor: Theme.of(context).primaryColor,
                elevation: 0,
                fixedSize: Size(size.width / 3, size.height * 0.05),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: orderRating,
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: () async {
                    final res = await apiCall.apiAddReview(
                      merchantId: merchantId,
                      rating: value.toString(),
                      comment: feedbackController.text,
                      orderId: orderId,
                    );
                    if (res['status_code'] == true) {
                      await apiCall.sendNotification(
                        title: "User Feedback",
                        body: "${userName} Give you review",
                        to: res['device_id'],
                      );
                    }
                    Navigator.pop(context);
                    log("$res", name: "Rating Response");
                  },
                  child: Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    fixedSize: Size(size.width / 3, size.height * 0.05),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

String setMonth(int month) {
  switch (month) {
    case 01:
      return "Jan";
    case 02:
      return "Feb";
    case 03:
      return "Mar";
    case 04:
      return "Apr";
    case 05:
      return "May";
    case 06:
      return "Jun";
    case 07:
      return "Jul";
    case 08:
      return "Aug";
    case 09:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";
    case 12:
      return "Dec";
    default:
      return "";
  }
}
