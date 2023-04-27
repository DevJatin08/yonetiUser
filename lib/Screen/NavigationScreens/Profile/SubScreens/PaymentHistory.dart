import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';

class PaymentHistory extends StatefulWidget {
  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: templatePadding,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "21 September 2021",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.white,
                                fontFamily: 'bold',
                                fontSize: 15),
                          ),
                          Text(
                            "\$1.00",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.white,
                                fontFamily: 'bold',
                                fontSize: 15),
                          ),
                        ],
                      ),
                      Container(
                        child: (index.isEven)
                            ? Text(
                                "Paid Successfully",
                                style: TextStyle(
                                    height: 1.5,
                                    // fontFamily: 'bold',
                                    color: Colors.white,
                                    fontFamily: 'semiBold',
                                    fontSize: 11),
                              )
                            : Text(
                                "Payment Failed",
                                style: TextStyle(height: 1.5, color: Colors.red, fontSize: 11),
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(color: Colors.grey, height: 0),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
