import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Reviews/TopReviews.dart';
import 'package:userapp/Model/TopPhotos/TopPhotosDetail.dart';
import 'package:userapp/Screen/NavigationScreens/Yoneti/Components/TopPhoto.dart';
import 'package:userapp/Screen/NavigationScreens/Yoneti/Components/TopReview.dart';
import 'package:userapp/Services/Services/TopYoneti.dart';

class TopFinder extends StatefulHookWidget {
  TopFinder({Key? key}) : super(key: key);

  @override
  _TopFinderState createState() => _TopFinderState();
}

class _TopFinderState extends State<TopFinder> {
  List title = ['Reviews', 'Photos'];
  int selectTitle = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _topphotosProvider = useProvider(topphotosProvider);
    return Scaffold(
      body: Column(
        children: [
          Material(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Top Yoneti',
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontFamily: 'bold', fontSize: 32, color: thirdColor),
                            ),
                          ],
                        ),
                        Divider(
                          color: cardSubTextColor.withOpacity(0.5),
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: ListView.builder(
                      itemCount: title.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectTitle = index;
                            });
                          },
                          child: Container(
                            width: size.width / 2,
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: selectTitle == index ? primaryColor : Color(0xfff2f2f3), width: 4))),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title[index],
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(fontFamily: 'bold', fontSize: 16, color: selectTitle == index ? primaryColor : thirdColor),
                                  ),
                                  index == 0
                                      ? FutureBuilder<TopReviews>(
                                          future: TopYoneti().topReviews(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              final data = snapshot.data;
                                              return Text(
                                                "${data?.reviews?.length}",
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    fontFamily: 'bold', fontSize: 12, color: selectTitle == index ? primaryColor : cardSubTextColor),
                                              );
                                            }
                                            return Text(
                                              "0",
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontFamily: 'bold', fontSize: 12, color: selectTitle == index ? primaryColor : cardSubTextColor),
                                            );
                                          },
                                        )
                                      : FutureBuilder<TopPhotosData>(
                                          future: _topphotosProvider.getTopPhotos(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              final data = snapshot.data;

                                              return Text(
                                                "${data?.photos.length ?? "0"}",
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    fontFamily: 'bold', fontSize: 12, color: selectTitle == index ? primaryColor : cardSubTextColor),
                                              );
                                            }
                                            return Text(
                                              "0",
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontFamily: 'bold', fontSize: 12, color: selectTitle == index ? primaryColor : cardSubTextColor),
                                            );
                                          },
                                        ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: selectTitle == 0 ? TopReview() : TopPhotos(),
          )
        ],
      ),
    );
  }
}
