import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Model/Home/HomeMerchantList.dart';
import 'package:userapp/Model/NearBy/NearbyDetails.dart';
import 'package:userapp/Screen/CommonWidgets/Card/GridViewCard.dart';
import 'package:userapp/Screen/NavigationScreens/Discovery/DiscoveryCard.dart';
import 'package:userapp/Screen/NavigationScreens/NearBy/NearBy.dart';

class Hor_Card_List extends StatelessWidget {
  String title;
  List<Marchant>? marchantdetails;

  Hor_Card_List({required this.title, this.marchantdetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 212,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: leftCardPadding),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 16, color: thirdColor, fontFamily: 'bold'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NearByScreen()));
                  },
                  child: Text(
                    'See all',
                    style: TextStyle(
                        fontSize: 16, color: primaryColor, fontFamily: 'bold'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: leftCardPadding),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: marchantdetails!.length,
                itemBuilder: (BuildContext context, int index) {
                  return new DiscoveyCard(
                    marchantDetail: marchantdetails![index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
