import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Reviews/SeeAllReview.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';

class MyReviews extends StatefulHookWidget {
  @override
  _MyReviewsState createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _marchantProvider = useProvider(marchantProvider);

    return FutureBuilder<ReviewData>(
        future: _marchantProvider.GetAllReviwe(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height * 0.5,
                  child: data!.allReviews.isEmpty
                      ? Center(
                          child: Text(
                            "No Reviews",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        )
                      : ListView.builder(
                          itemCount: data.allReviews.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 30),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage: NetworkImage(
                                                        'data.allReviews[index].avatar'),
                                                  ),
                                                  // Container(
                                                  //   width: 15,
                                                  //   height: 15,
                                                  //   decoration: BoxDecoration(
                                                  //       color: Colors.white,
                                                  //       shape: BoxShape.circle),
                                                  //   child: Center(
                                                  //       child: Text(
                                                  //     '1',
                                                  //     style: TextStyle(
                                                  //         fontSize: 10,
                                                  //         color: thirdColor),
                                                  //   )),
                                                  // ),
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data.allReviews[index]
                                                          .reviewedBy,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontFamily: 'bold',
                                                      ),
                                                    ),
                                                    Container(
                                                      width: size.width / 1.5,
                                                      child: Text(
                                                        data.allReviews[index]
                                                            .comments,
                                                        maxLines: 5,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    RichText(
                                                        text: TextSpan(
                                                            text: data
                                                                .allReviews[
                                                                    index]
                                                                .date
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            children: [
                                                          // TextSpan(
                                                          //   text: ' 11:45am',
                                                          //   style: TextStyle(
                                                          //       fontSize: 11,
                                                          //       color:
                                                          //           Colors.grey,
                                                          //       fontFamily:
                                                          //           'bold'),
                                                          // )
                                                        ])),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        // Container(
                                        //   child: (index.isOdd)
                                        //       ? Container(
                                        //           margin: EdgeInsets.symmetric(
                                        //               vertical: 15),
                                        //           child: Column(
                                        //             crossAxisAlignment:
                                        //                 CrossAxisAlignment.end,
                                        //             children: [
                                        //               Text(
                                        //                 "4.0",
                                        //                 textAlign:
                                        //                     TextAlign.end,
                                        //                 style: TextStyle(
                                        //                   fontSize: 15,
                                        //                   color: Colors.yellow,
                                        //                   fontFamily: 'bold',
                                        //                 ),
                                        //               ),
                                        //               Container(
                                        //                 child: Row(
                                        //                   children: [
                                        //                     SizedBox(
                                        //                       height: 30,
                                        //                       child: ListView
                                        //                           .builder(
                                        //                               scrollDirection:
                                        //                                   Axis
                                        //                                       .horizontal,
                                        //                               shrinkWrap:
                                        //                                   true,
                                        //                               itemCount:
                                        //                                   4,
                                        //                               itemBuilder:
                                        //                                   (context,
                                        //                                       subindex) {
                                        //                                 return Icon(
                                        //                                   Icons
                                        //                                       .star_outline,
                                        //                                   color:
                                        //                                       Colors.yellow,
                                        //                                   size:
                                        //                                       20,
                                        //                                 );
                                        //                               }),
                                        //                     )
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         )
                                        //       : Container(
                                        //           margin: EdgeInsets.symmetric(
                                        //               vertical: 15),
                                        //           child: Column(
                                        //             crossAxisAlignment:
                                        //                 CrossAxisAlignment.end,
                                        //             children: [
                                        //               Text(
                                        //                 "5.0",
                                        //                 textAlign:
                                        //                     TextAlign.end,
                                        //                 style: TextStyle(
                                        //                   fontSize: 16,
                                        //                   color: Colors.white,
                                        //                   fontFamily: 'bold',
                                        //                 ),
                                        //               ),
                                        //               Container(
                                        //                 child: Row(
                                        //                   children: [
                                        //                     SizedBox(
                                        //                       height: 30,
                                        //                       child: ListView
                                        //                           .builder(
                                        //                               scrollDirection:
                                        //                                   Axis
                                        //                                       .horizontal,
                                        //                               shrinkWrap:
                                        //                                   true,
                                        //                               itemCount:
                                        //                                   5,
                                        //                               itemBuilder:
                                        //                                   (context,
                                        //                                       subindex) {
                                        //                                 return Icon(
                                        //                                   Icons
                                        //                                       .star_outline,
                                        //                                   color:
                                        //                                       Colors.white,
                                        //                                   size:
                                        //                                       20,
                                        //                                 );
                                        //                               }),
                                        //                     )
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        // )
                                      ],
                                    ),
                                    Divider(
                                      indent: 10,
                                      color: Colors.white,
                                      height: 0,
                                    ),
                                  ],
                                ));
                          },
                        ),
                ),
              ],
            );
          }

          return Center(
            child: LoadingWidget(),
          );
        });
  }
}
