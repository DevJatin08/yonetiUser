import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Home/payment_history_model.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/Components/Schedule.dart';

class PaymentHistory extends ConsumerStatefulWidget {
  PaymentHistory({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends ConsumerState<PaymentHistory> {
  // getPaymentHistory

  String selectedStartDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String selectedLastDate = DateFormat("yyyy-MM-dd")
      .format(DateTime.utc(DateTime.now().year, DateTime.now().month));
  @override
  Widget build(BuildContext context) {
    final _homeServiceInfoProvider = ref.watch(homeServiceProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Payment History',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'bold'),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: IconButton(
                            icon: Icon(Icons.filter_alt),
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: false,
                                  context: context,
                                  builder: (context) {
                                    return Schedule(
                                      onTapList: (selctedList) {
                                        selectedStartDate = selctedList[1];

                                        selectedLastDate = selctedList[0];
                                        setState(() {});
                                        // log(selctedList
                                        //     .toString());
                                      },
                                    );
                                  });
                            },
                          ))
                    ])),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xff454545),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: FutureBuilder<PaymentHistoryModel>(
                      future: _homeServiceInfoProvider.getPaymentHistory(
                        startData: selectedLastDate,
                        lastDate: selectedStartDate,
                      ),
                      builder: (context, snapShot) {
                        if (!snapShot.hasData) {
                          return Center(
                            child: Text(
                              'No Transction Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else
                          return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: snapShot.data!.result != null
                                  ? Expanded(
                                      child: ListView.builder(
                                          itemCount:
                                              snapShot.data!.result!.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapShot
                                                          .data!
                                                          .result![index]
                                                          .createdAt!,
                                                      style: TextStyle(
                                                          letterSpacing: 1,
                                                          color: Colors.white,
                                                          fontFamily: 'bold',
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      "\$${snapShot.data!.result![index].amount!}",
                                                      style: TextStyle(
                                                          letterSpacing: 1,
                                                          color: Colors.white,
                                                          fontFamily: 'bold',
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  child: snapShot
                                                              .data!
                                                              .result![index]
                                                              .paymentStatus ==
                                                          'Success'
                                                      ? Text(
                                                          snapShot
                                                              .data!
                                                              .result![index]
                                                              .paymentStatus!,
                                                          style: TextStyle(
                                                              height: 1.5,
                                                              // fontFamily: 'bold',
                                                              color:
                                                                  Colors.green,
                                                              fontFamily:
                                                                  'semiBold',
                                                              fontSize: 11),
                                                        )
                                                      : Text(
                                                          snapShot
                                                              .data!
                                                              .result![index]
                                                              .paymentStatus!,
                                                          style: TextStyle(
                                                              height: 1.5,
                                                              color: Colors.red,
                                                              fontSize: 11),
                                                        ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Divider(
                                                    color: Colors.grey,
                                                    height: 0),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            );
                                          }),
                                    )
                                  : Center(
                                      child: Text(
                                        'No Transction Found',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ));
                      }),
                )
                //  widget(child: widget.widget),
                )
          ],
        ),
      ),
    );

    // Padding(
    //   padding: templatePadding,
    //   child: Column(
    //     children: [

    //     ],
    //   ),
    // );
  }
}
