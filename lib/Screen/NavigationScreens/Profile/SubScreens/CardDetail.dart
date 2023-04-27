import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Constant/InputStyle.dart';
import 'package:userapp/Model/Cardinfo/Cardinfo.dart';
import 'package:userapp/Model/ServiceAgainst/ServiceAgainst.dart';
import 'package:userapp/Screen/CommonWidgets/CustomButton.dart';
import 'package:userapp/Screen/CommonWidgets/EditField.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/NavigationScreens/BaseScreen.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/SubScreens/Confirmation.dart';

class CardDetail extends StatefulHookWidget {
  double? amount;
  String? marchantId;
  String? selectTime;
  String? agentID;
  DateTime? selectDate;
  String? completionTime;
  Set<MarchantServiceData>? SelectService;

  CardDetail({this.amount, this.marchantId, this.selectDate, this.selectTime, this.agentID, this.SelectService, this.completionTime});

  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetail> {
  TextEditingController cardnumber = TextEditingController();

  TextEditingController expired = TextEditingController();

  TextEditingController cvv = TextEditingController();

  TextEditingController name = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String Cardnumber = "";
  String Cardexpiredate = "";
  String Cardcvv = "";
  String CardHoldername = "";
  bool value = false;
  bool cardSelected = false;
  int selectedCard = 0;
  double horizontalDrag = 0;
  Map<String, dynamic>? paymentIntentData;
  List date = [];

//  PaymentMethod? paymentMethodData;
//   paymentMethodID() async {

//   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // paymentMethodID();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _addcardProvider = useProvider(addcardProvider);
    return Stack(
      children: [
        Container(
          height: size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.13, right: 20, left: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Credit/Debit card',
                            style: TextStyle(fontSize: 18, fontFamily: 'bold', color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          EditField(
                            keyboardType: TextInputType.number,
                            controller: cardnumber,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CardNumberFormatter(value: 4, message: " "),
                              LengthLimitingTextInputFormatter(19),
                            ],
                            validator: (val) {
                              if (val == "" || cardnumber.text.isEmpty || cardnumber.text.length < 19) {
                                return cardnumber.text.length < 19
                                    ? cardnumber.text.length == 0
                                        ? "Enter Card Number"
                                        : "Enter Valid Card Number"
                                    : "Enter Card Number";
                              }
                              return null;
                            },
                            onsave: (val) {
                              setState(() {
                                Cardnumber = val;
                              });
                              return null;
                            },
                            onChanged: (val) {
                              _formkey.currentState!.validate();
                            },
                            inputDecoration: transparentInputDecoration.copyWith(
                                isCollapsed: false,
                                fillColor: Color(0xffe7e7e7),
                                filled: true,
                                hintStyle: TextStyle(color: Color(0xff9d9d9d), fontSize: 15)),
                            hint: 'Card number',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: EditField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CardNumberFormatter(value: 2, message: "/"),
                                    LengthLimitingTextInputFormatter(5),
                                  ],
                                  onChanged: (val) {
                                    _formkey.currentState!.validate();
                                  },
                                  validator: (val) {
                                    if (val == "" || expired.text.isEmpty || expired.text.length < 5) {
                                      return expired.text.length < 5
                                          ? expired.text.length == 0
                                              ? "Enter Expired Date"
                                              : "Enter Valid Date"
                                          : "Enter Expired Date";
                                    }
                                    return null;
                                  },
                                  controller: expired,
                                  onsave: (val) {
                                    setState(() {
                                      Cardexpiredate = val;
                                    });
                                    return null;
                                  },
                                  inputDecoration: transparentInputDecoration.copyWith(
                                      isCollapsed: false,
                                      fillColor: Color(0xffe7e7e7),
                                      filled: true,
                                      hintStyle: TextStyle(color: Color(0xff9d9d9d), fontSize: 15)),
                                  hint: 'Expired',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: EditField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  controller: cvv,
                                  onChanged: (val) {
                                    _formkey.currentState!.validate();
                                  },
                                  validator: (val) {
                                    if (val == "" || cvv.text.isEmpty || cvv.text.length < 3) {
                                      return cvv.text.length < 3
                                          ? cvv.text.length == 0
                                              ? "Enter Card Cvv"
                                              : "Enter Valid Card Cvv"
                                          : "Enter Card Cvv";
                                    }
                                    return null;
                                  },
                                  onsave: (val) {
                                    setState(() {
                                      Cardcvv = val;
                                    });
                                    return null;
                                  },
                                  inputDecoration: transparentInputDecoration.copyWith(
                                      isCollapsed: false,
                                      fillColor: Color(0xffe7e7e7),
                                      filled: true,
                                      hintStyle: TextStyle(color: Color(0xff9d9d9d), fontSize: 15)),
                                  hint: 'CVV',
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          EditField(
                            controller: name,
                            validator: (val) {
                              if (val == "" || val == " ") {
                                return "Enter Card Holder Name";
                              }
                              return null;
                            },
                            onsave: (val) {
                              setState(() {
                                CardHoldername = val;
                              });
                              return null;
                            },
                            onChanged: (val) {
                              _formkey.currentState!.validate();
                            },
                            inputDecoration: transparentInputDecoration.copyWith(
                                isCollapsed: false,
                                fillColor: Color(0xffe7e7e7),
                                filled: true,
                                hintStyle: TextStyle(color: Color(0xff9d9d9d), fontSize: 15)),
                            hint: 'Cardholder Name',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                value = !value;
                              });
                            },
                            child: Row(
                              children: [
                                value
                                    ? Container(
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(width: 2, color: Colors.white),
                                        ),
                                        width: 20,
                                        height: 20,
                                      ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Save card Information',
                                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            text: 'Add card',
                            //width: 0.5,
                            voidCallback: value
                                ? () {
                                    if (_formkey.currentState!.validate()) {
                                      _formkey.currentState!.save();
                                      _addcardProvider.addCardInfo(
                                          card_no: Cardnumber, expire: Cardexpiredate, holder_name: CardHoldername, cvv: Cardcvv);
                                      setState(() {
                                        date = Cardexpiredate.split("/");
                                        cardnumber.clear();
                                        cvv.clear();
                                        name.clear();
                                        expired.clear();
                                      });
                                    }
                                  }
                                : () {
                                    return null;
                                  },
                            radius: 30,
                            // height: 10,
                            textColor: value ? Colors.black : Colors.black54,
                            color: value ? Colors.white : Colors.grey,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Center(
                          //   child: Container(
                          //       height: 180,
                          //       width: size.width * 0.8,
                          //       decoration: BoxDecoration(
                          //         color: Color(0xff5d5d5d),
                          //         borderRadius: BorderRadius.circular(5),
                          //       ),
                          //       child: FutureBuilder<Cardinfo>(
                          //         future: _addcardProvider.getCardinfo(),
                          //         builder: (context, snapshot) {
                          //           if (snapshot.hasData) {
                          //             final data = snapshot.data;
                          //             return ListView.builder(
                          //                 itemCount: 1,
                          //                 itemBuilder: (context, index) {
                          //                   return Padding(
                          //                     padding:
                          //                         const EdgeInsets.symmetric(
                          //                             horizontal: 10,
                          //                             vertical: 10),
                          //                     child: GestureDetector(
                          //                       onTap: () {
                          //                         setState(() {
                          //                           selectedCard = index;
                          //                         });
                          //                       },
                          //                       child: Container(
                          //                         height: 40,
                          //                         child: Row(
                          //                           children: [
                          //                             Expanded(
                          //                               child: Row(
                          //                                 children: [
                          //                                   Image.network(
                          //                                     'https://cdn.trendhunterstatic.com/thumbs/mastercard-logo.jpeg',
                          //                                     height: 30,
                          //                                     width: 40,
                          //                                     fit: BoxFit.cover,
                          //                                   ),
                          //                                   SizedBox(
                          //                                     width:
                          //                                         size.width *
                          //                                             0.02,
                          //                                   ),
                          //                                   Text(
                          //                                     '${data!.cardNo}',
                          //                                     style: TextStyle(
                          //                                         color: Colors
                          //                                             .white,
                          //                                         fontFamily:
                          //                                             'bold',
                          //                                         fontSize: 15),
                          //                                   ),
                          //                                 ],
                          //                               ),
                          //                             ),
                          //                             Container(
                          //                               decoration:
                          //                                   BoxDecoration(
                          //                                       shape: BoxShape
                          //                                           .circle,
                          //                                       color: Colors
                          //                                           .white),
                          //                               child: Padding(
                          //                                 padding:
                          //                                     const EdgeInsets
                          //                                         .all(4.0),
                          //                                 child: Container(
                          //                                   height: 12,
                          //                                   width: 12,
                          //                                   decoration: BoxDecoration(
                          //                                       border: Border.all(
                          //                                           color: selectedCard ==
                          //                                                   index
                          //                                               ? Colors
                          //                                                   .black
                          //                                               : Colors
                          //                                                   .transparent,
                          //                                           width: 2),
                          //                                       shape: BoxShape
                          //                                           .circle),
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   );
                          //                 });
                          //           }
                          //           return LoadingWidget();
                          //         },
                          //       )),
                          // ),
                          Center(
                            child: Container(
                                height: 180,
                                width: size.width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: FutureBuilder<Cardinfo>(
                                  future: _addcardProvider.getCardinfo(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final data = snapshot.data;
                                      return GestureDetector(
                                        onHorizontalDragUpdate: (horizontal) {
                                          setState(() {
                                            horizontalDrag += horizontal.delta.dx;
                                            horizontalDrag %= 360;
                                          });
                                        },
                                        onTap: () {
                                          setState(() {
                                            cardSelected = !cardSelected;
                                            Cardnumber = data!.cardNo;
                                            Cardcvv = data.cvv;
                                            date = data.expired.split("/");
                                          });
                                        },
                                        child: Transform(
                                          transform: Matrix4.identity()
                                            ..setEntry(3, 2, 0.001)
                                            ..rotateY(pi / 180 * horizontalDrag),
                                          alignment: Alignment.center,
                                          child: Container(
                                            width: 300,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              gradient: LinearGradient(
                                                colors: [
                                                  cardSelected ? Color.fromARGB(255, 77, 147, 179) : Color(0xff323232),
                                                  cardSelected ? Color.fromARGB(255, 35, 100, 131) : Color(0xff000000)
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                            ),
                                            child: horizontalDrag <= 90 || horizontalDrag >= 270 ? cardFront(data: data) : cardBack(),
                                          ),
                                        ),
                                      );
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       horizontal: 10, vertical: 10),
                                      //   child: GestureDetector(
                                      //     onTap: () {
                                      //       setState(() {
                                      //         col = !col;
                                      //       });

                                      //       card_number = data!.cardNo;
                                      //     },
                                      //     child: Column(
                                      //       children: [
                                      //         Container(
                                      //           height: 40,
                                      //           child: Expanded(
                                      //             child: Row(
                                      //               children: [
                                      //                 Image.network(
                                      //                   'https://cdn.trendhunterstatic.com/thumbs/mastercard-logo.jpeg',
                                      //                   height: 30,
                                      //                   width: 40,
                                      //                   fit: BoxFit.cover,
                                      //                 ),
                                      //                 SizedBox(
                                      //                   width:
                                      //                       size.width * 0.02,
                                      //                 ),
                                      //                 Text(
                                      //                   '${data!.cardNo}',
                                      //                   style: TextStyle(
                                      //                       color: Color(
                                      //                           0xff374961),
                                      //                       fontFamily: 'bold',
                                      //                       fontSize: 15),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         SizedBox(
                                      //           height: 20,
                                      //         ),
                                      //         Padding(
                                      //           padding: const EdgeInsets.only(
                                      //               left: 8, right: 8),
                                      //           child: Row(
                                      //             mainAxisAlignment:
                                      //                 MainAxisAlignment
                                      //                     .spaceBetween,
                                      //             children: [
                                      //               Row(
                                      //                 children: [
                                      //                   Text(
                                      //                     "Expire date - ",
                                      //                     style: TextStyle(
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .bold),
                                      //                   ),
                                      //                   Text(
                                      //                     data.expired,
                                      //                     style: TextStyle(
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .bold),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //               Row(
                                      //                 children: [
                                      //                   Text(
                                      //                     "cvv - ",
                                      //                     style: TextStyle(
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .bold),
                                      //                   ),
                                      //                   Text(
                                      //                     data.cvv,
                                      //                     style: TextStyle(
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .bold),
                                      //                   ),
                                      //                 ],
                                      //               )
                                      //             ],
                                      //           ),
                                      //         ),
                                      //         SizedBox(height: 20),
                                      //         Padding(
                                      //           padding: const EdgeInsets.only(
                                      //               left: 8),
                                      //           child: Row(
                                      //             children: [
                                      //               Icon(Icons.person),
                                      //               SizedBox(width: 20),
                                      //               Text(
                                      //                 data.cardHolderName,
                                      //                 style: TextStyle(
                                      //                     fontWeight:
                                      //                         FontWeight.bold),
                                      //               ),
                                      //           ],
                                      //         ),
                                      //       )
                                      //     ],
                                      //   ),
                                      // ),
                                      // );
                                    }
                                    return LoadingWidget();
                                  },
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: size.width,
                decoration:
                    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (cardSelected || cardnumber.text.length == 19 && cvv.text.length == 3 && expired.text.length == 5 && name.text.isNotEmpty)
                        InkWell(
                          onTap: () async {
                            //  showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return ConfirmationScreen(icon: Icon(Icons.ac_unit),name: "Tapped Successfully",title: "Tapped", color: Colors.amberAccent,);
                            //     });
                            if (cardnumber.text.length == 19 && cvv.text.length == 3 && expired.text.length == 5 && name.text.isNotEmpty) {
                              _formkey.currentState!.save();
                            }
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return LoadingWidget();
                                });
                            await makePayment();
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Color(0xff454545), borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                              child: Row(
                                children: [
                                  Text(
                                    'Pay Now',
                                    style: TextStyle(fontSize: 12, fontFamily: 'bold', color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 12,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '\$${widget.amount == null ? "0" : (widget.amount)!.toStringAsFixed(2).toString()}',
                                  style: TextStyle(fontSize: 21, color: Color(0xff9d9d9d)),
                                ),
                                Text(
                                  'Exclusive of Taxes',
                                  style: TextStyle(fontSize: 14, color: Color(0xff9d9d9d)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> makePayment() async {
    try {
      await Stripe.instance.dangerouslyUpdateCardDetails(
          CardDetails(cvc: Cardcvv, expirationMonth: int.parse(date[0]), expirationYear: int.parse(date[1]), number: Cardnumber));

      final paymentMethod = await Stripe.instance.createPaymentMethod(PaymentMethodParams.card());

      final paymentIntentResult = await createPaymentIntent(currency: 'USD', paymentMethodId: paymentMethod.id, useStripeSdk: true);
      final paymentIntent = await Stripe.instance.retrievePaymentIntent(paymentIntentResult['client_secret']);
      //  .handleCardAction(paymentIntentResult['client_secret']);

      await confirmIntent(paymentIntent.id);
    } catch (e, s) {}
  }

  Future<Map<String, dynamic>> createPaymentIntent({
    required bool useStripeSdk,
    required String paymentMethodId,
    required String currency,
    List<Map<String, dynamic>>? items,
  }) async {
    Map<String, dynamic> body = {
      'amount': calculateAmount(widget.amount == null ? "00" : widget.amount!.toStringAsFixed(2)),
      'currency': currency,
      'payment_method': paymentMethodId,
      'payment_method_types[]': 'card',
      'confirm': 'true',
    };

    Dio _dio = Dio(BaseOptions(headers: {
      'Authorization': 'Bearer sk_test_51KPBpMD7PODSamJcenIlY0rx1Szst6xqTFVnnK57G5rb4sADu0RlReSTYGXKjDiukJjJbVoQygTmqzNgjvyEBgK5002HGNKx83',
      'Content-Type': 'application/x-www-form-urlencoded'
    }));
    Response response = await _dio.post(
      'https://api.stripe.com/v1/payment_intents',
      data: body,
    );

    if (response.data["status"] == "succeeded") {
      Navigator.of(context).pop();
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return ConfirmationScreen(
              name: 'Your Payment Has Been \nSuccessfully Updated',
              color: Color(0xff4b6057),
              icon: Icon(
                Icons.check,
                color: Colors.white,
                size: 50,
              ),
            );
          });
      Timer(Duration(seconds: 2), () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BaseHomeWidget()), (route) => false);
      });
      log("${widget.selectDate.toString()}", name: "Card Order Date");
      context.read(marchantProvider).bookingService(
            marchantId: widget.marchantId.toString(),
            orderDate: widget.selectDate!,
            time: widget.selectTime.toString(),
            agentID: widget.agentID.toString(),
            totalAmount: widget.amount.toString(),
            completionTime: widget.completionTime.toString(),
            serviceList: widget.SelectService!.toSet(),
          );
    }

    print('Create Intent reponse ===> ${response.data}');
    print(body);
    return jsonDecode(response.data);
  }

  Future<Map<String, dynamic>> GetIntentID({
    required String paymentIntentId,
  }) async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer sk_test_51KPBpMD7PODSamJcenIlY0rx1Szst6xqTFVnnK57G5rb4sADu0RlReSTYGXKjDiukJjJbVoQygTmqzNgjvyEBgK5002HGNKx83',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: json.encode({'paymentIntentId': paymentIntentId}),
    );
    print("sdfsdfsdfdgdfgfd");
    return json.decode(response.body);
  }

  Future<void> confirmIntent(String paymentIntentId) async {
    final result = await GetIntentID(paymentIntentId: paymentIntentId);
    if (result['error'] != null) {
    } else {}
  }

  calculateAmount(String amount) {
    // String aa = ((double.parse(amount)).toString() + 00.toString()).toString();
    final a = amount.toString().replaceAll(".", "");
    return a.toString();
  }

  Widget cardFront({required Cardinfo? data}) {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '${data!.cardHolderName}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              // Text(
              //   '|',
              //   style: TextStyle(
              //     color: Colors.grey,
              //     letterSpacing: 10,
              //     fontSize: 10,
              //   ),
              // ),
              // Text(
              //   'Universal Bank',
              //   style: TextStyle(
              //     color: Colors.grey,
              //     fontSize: 10,
              //   ),
              // )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Image.asset(
            'assets/images/chip.png',
            height: 25,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "${data.cardNo}",
            // "${data.cardNo.toString().substring(0, 4)} ${data.cardNo.toString().substring(4, 8)} ${data.cardNo.toString().substring(8, 12)} ${data.cardNo.toString().substring(12, 16)}",
            style: TextStyle(color: Colors.grey[300], fontSize: 18, wordSpacing: 15, shadows: [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 2,
                color: Colors.black,
                offset: Offset(2, 2),
              )
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Exp ${data.expired}',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'Cvv ${data.cvv}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardBack() {
    return Container(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.grey[700],
          )
        ],
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  int value;
  String message;

  CardNumberFormatter({required this.value, required this.message});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = new StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % value == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(message);
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: new TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
