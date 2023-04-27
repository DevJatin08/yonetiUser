import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Screen/CommonWidgets/Appbars/AppbarWithIcons.dart';
import 'package:userapp/Screen/CommonWidgets/Card/GridViewCard.dart';
import 'package:userapp/Screen/CommonWidgets/Card/ListViewCard.dart';
import 'package:userapp/Screen/CommonWidgets/Lists/Hor_Card_List.dart';
import 'package:userapp/Screen/CommonWidgets/Lists/SponsorList.dart';

class HomeMaster extends StatefulWidget {
  HomeMaster({Key? key}) : super(key: key);

  @override
  _HomeMasterState createState() => _HomeMasterState();
}

class _HomeMasterState extends State<HomeMaster> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppbarWithIcon(
          title: 'Discover Services',
          icons: Row(
            children: [
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/SVG/bellicon.svg',
                  width: 28,
                  height: 28,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Hor_Card_List(
                  title: 'Barbershop - Men',
                ),
                SizedBox(
                  height: 20,
                ),
                Hor_Card_List(
                  title: 'Beauty Salon - Female',
                ),
                //Clinics
                SizedBox(
                  height: 20,
                ),
                Hor_Card_List(
                  title: 'Clinics',
                ),
                SizedBox(
                  height: 20,
                ),
                SponsorList()
              ],
            ),
          ),
        )
      ],
    );
  }
}
