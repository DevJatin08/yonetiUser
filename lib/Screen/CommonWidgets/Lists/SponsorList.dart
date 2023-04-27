import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';

class SponsorList extends StatelessWidget {
  const SponsorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 160,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: leftCardPadding),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Sponsord',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xfff5821f),
                          fontFamily: 'bold'),
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                        fontSize: 16, color: primaryColor, fontFamily: 'bold'),
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
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: new Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? Color(0xffe8334a)
                                  : Color(0xfff5821f),
                              borderRadius: BorderRadius.circular(cardRadius)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Brand name',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: 'bold'),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          )),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
