import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Model/Marchant/MarchantDetail.dart';
import 'package:userapp/Screen/CommonWidgets/Appbars/Appbar.dart';
import 'package:userapp/Screen/CommonWidgets/Card/Nearbycard.dart';

class NearbyPage extends StatefulWidget {
  List<Nearby>? nearby;
  NearbyPage({this.nearby});
  @override
  _NearbyPageState createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2.3;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          AppbarWithoutIcon(title: 'NearBy'),
          Expanded(
              child: widget.nearby!.isEmpty
                  ? Center(child: Text("No Nearby"))
                  : GridView.builder(
                      itemCount: widget.nearby!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (itemWidth / gridCardHeight),
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return new NearbyCard(
                          marchantDetail: widget.nearby![index],
                          // featured: index < 3 ? true : false,
                          leftPadding: standardPadding,
                          rightPadding: standardPadding,
                        );
                      },
                    )),
        ],
      )),
    );
  }
}
