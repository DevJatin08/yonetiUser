import 'package:flutter/material.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/Components/Template.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/SubScreens/CardDetail.dart';

class PaymentGateWay extends StatefulWidget {
  double? amount;

  PaymentGateWay({Key? key, this.amount}) : super(key: key);

  @override
  _PaymentGateWayState createState() => _PaymentGateWayState();
}

class _PaymentGateWayState extends State<PaymentGateWay> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: size.height * 0.13, right: 50, left: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfileTemplate(
                        widget: CardDetail(amount: widget.amount),
                        name: 'Payment',
                        url: 'https://cdn.trendhunterstatic.com/thumbs/mastercard-logo.jpeg',
                        extraImage: true,
                      );
                    },
                  ),
                );
              },
              child: options('Card / Debit card', 'card.png', Colors.white)),
          Divider(
            color: Colors.white.withOpacity(0.2),
            height: 25,
          ),
          options('Paypal', 'paypal.png', null),
          Divider(
            color: Colors.white.withOpacity(0.2),
            height: 25,
          ),
          options('Stripe', 'stripe.png', null),
          Divider(
            color: Colors.white.withOpacity(0.2),
            height: 25,
          ),
          options('2Checkout', '2check.png', null),
          Divider(
            color: Colors.white.withOpacity(0.2),
            height: 25,
          ),
          options('WePay', 'wepay.png', null),
        ],
      ),
    );
  }

  Widget options(
    String title,
    String url,
    Color? color,
  ) {
    return Row(
      children: [
        Container(
          child: Image.asset(
            'assets/images/${url}',
            color: color,
            width: 28,
            height: 28,
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontFamily: 'medium',
            ),
          ),
        ),
      ],
    );
  }
}
