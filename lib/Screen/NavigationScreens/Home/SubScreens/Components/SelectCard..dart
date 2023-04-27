import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';

class SelectCard extends StatefulWidget {
  ValueChanged<int> cardIndex;
  int index;
  SelectCard({required this.index, required this.cardIndex});

  @override
  _SelectCardState createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70 * 4,
      child: ListView.builder(
          itemCount: 4,
          itemBuilder: (contextm, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    widget.cardIndex(index);
                    Navigator.pop(context);
                  },
                  child: PaymentCard(
                    borderColor: index == widget.index
                        ? thirdColor
                        : reversationCardBorder,
                  )),
            );
          }),
    );
  }
}

class PaymentCard extends StatelessWidget {
  Color? borderColor;
  PaymentCard({this.borderColor = reversationCardBorder});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor!),
          borderRadius: BorderRadius.circular(cardRadius)),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 50,
            decoration: BoxDecoration(
                // color: Color(0xff759bfa),.
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(cardRadius),
                  bottomLeft: Radius.circular(cardRadius),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'American Express',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13,
                      color: cardSubTextColor,
                      fontFamily: 'bold'),
                ),
                Text(
                  '8890 4825 **** **** ****',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: cardSubTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
