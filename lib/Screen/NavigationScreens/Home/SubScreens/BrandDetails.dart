import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Bookmark/BookmarkDetail.dart';
import 'package:userapp/Model/Marchant/MarchantDetail.dart';
import 'package:userapp/Screen/CommonWidgets/BackButton.dart';
import 'package:userapp/Screen/CommonWidgets/Card/Nearbycard.dart';
import 'package:userapp/Screen/CommonWidgets/Card/SwipeCard.dart';
import 'package:userapp/Screen/CommonWidgets/CustomButton.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/NavigationScreens/Components/Picture/AllPictureGrid.dart';
import 'package:userapp/Screen/NavigationScreens/Components/Review/Review.dart';
import 'package:userapp/Screen/NavigationScreens/Home/Chat/Chat.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/Components/nearbySeeall.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/Reversation.dart';
import 'package:userapp/Services/Services/MarchantService.dart';

class BrandDetail extends ConsumerStatefulWidget {
  String? bookmark_id;

  // int index;
  BrandDetail({
    // required this.index,
    this.bookmark_id,
  });

  @override
  _BrandDetailState createState() => _BrandDetailState();
}

class _BrandDetailState extends ConsumerState<BrandDetail> {
  double hor_Size = 8.0;
  String defaultavtar = "https://i0.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _marchantProvider = ref.read(marchantProvider);
    return Scaffold(
      body: FutureBuilder<MarchantDetail>(
          future: _marchantProvider.marchantDetail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              final data = snapshot.data!;
              return SafeArea(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: size.width,
                      height: size.height,
                      // color: thirdColor,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                data.avatar!.isEmpty ? defaultavtar : data.avatar.toString(),
                              ),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      width: size.width,
                      height: size.height * 0.7,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(hor_Size),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data!.name!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff173143),

                                          // fontWeight: FontWeight.bold,
                                          fontFamily: 'bold'),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(cardRadius), color: primaryColor),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      child: Text(
                                        _marchantProvider.rating,
                                        style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'bold'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: bodyColor,
                              thickness: 3.5,
                            ),
                            ButtonsClick(
                              snapshot: snapshot.data!,
                              bookmark_ID: widget.bookmark_id.toString(),
                              marchantProvider: _marchantProvider,
                            ),
                            // Material(
                            //   color: Colors.white,
                            //   elevation: 2,
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(
                            //         horizontal: 40, vertical: 10),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         rowIcons(
                            //             FontAwesomeIcons.shareSquare,
                            //             'Share',
                            //             snapshot.data!.totalShares!, () {
                            //           Share.share(
                            //               'check out my website https://example.com');
                            //         }),
                            //         rowIcons(FontAwesomeIcons.star, 'Review',
                            //             snapshot.data!.totalReviews!, () {
                            //           Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                   builder: (_) => ReviewPage()));
                            //         }),
                            //         rowIcons(Icons.camera_alt, 'Photo',
                            //             snapshot.data!.totalPhotos!, () {
                            //           Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                   builder: (_) => AllPictureGrid(
                            //                         name: snapshot.data!.name,
                            //                         reating: _marchantProvider
                            //                             .rating,
                            //                       )));
                            //         }),
                            //         rowIcons(
                            //             bookmark
                            //                 ? FontAwesomeIcons.solidBookmark
                            //                 : FontAwesomeIcons.bookmark,
                            //             'Bookmark',
                            //             snapshot.data!.totalBookmarks!, () {
                            //           setState(() {
                            //             bookmark = !bookmark;
                            //
                            //             bookmark
                            //                 ? FutureBuilder(
                            //                     builder: (context, snapshot) {
                            //                     return Container();
                            //                   })
                            //                 : Container();
                            //           });
                            //         })
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Container(
                              height: 120,
                              width: size.width,
                              // decoration: BoxDecoration(
                              //     image: DecorationImage(
                              //         image: AssetImage(
                              //   'assets/demo/map.png',
                              // ))),
                              child: Stack(
                                children: [
                                  // Image.asset(
                                  //   'assets/demo/map.png',
                                  //   fit: BoxFit.cover,
                                  //   width: size.width,
                                  // ),
                                  Container(
                                    decoration: new BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        colorFilter: new ColorFilter.mode(Colors.grey.withOpacity(0.4), BlendMode.dstATop),
                                        image: new AssetImage(
                                          'assets/demo/map.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: hor_Size),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!.address!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 16, color: cardSubTextColor, fontFamily: 'bold'),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          snapshot.data!.businessDetails!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 16, color: cardSubTextColor, fontFamily: 'bold'),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '${snapshot.data!.businessStartTime}AM to ${snapshot.data!.businessCloseTime}PM',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 16, color: cardSubTextColor, fontFamily: 'bold'),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              text: 'Reserve Your Seat',
                              voidCallback: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ReservationScreen(
                                      name: snapshot.data!.name,
                                      ratting: _marchantProvider.rating,
                                    ),
                                  ),
                                );
                              },
                              color: thirdColor,
                              fontSize: 16,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              text: 'Contact Merchant',
                              voidCallback: () {
                                ref.read(chatServiceProvider).setCustomerId(_marchantProvider.marchantId);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChatScreen(
                                      name: snapshot.data!.name!,
                                      merchantImage: snapshot.data!.avatar!,
                                      // ratting: _marchantProvider.rating,
                                    ),
                                  ),
                                );
                              },
                              fontSize: 16,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: hor_Size),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Details",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: thirdColor,
                                      fontFamily: 'bold',
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Website',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16, color: cardSubTextColor, fontFamily: 'bold'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          snapshot.data!.website!,
                                          textAlign: TextAlign.end,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 16, color: primaryColor, fontFamily: 'bold'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Call',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16, color: cardSubTextColor, fontFamily: 'bold'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          snapshot.data!.phoneNum!,
                                          textAlign: TextAlign.end,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 16, color: primaryColor, fontFamily: 'bold'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Business Type',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16, color: cardSubTextColor, fontFamily: 'bold'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          snapshot.data!.businessDetails!,
                                          textAlign: TextAlign.end,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 16, color: primaryColor, fontFamily: 'bold'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Average Cost',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16, color: cardSubTextColor, fontFamily: 'bold'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          snapshot.data!.averageCost!,
                                          textAlign: TextAlign.end,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 16, color: cardSubTextColor, fontFamily: 'bold'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: bodyColor,
                              thickness: 3.5,
                              height: 50,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: hor_Size),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Bookings',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 15, color: thirdColor, fontFamily: 'bold'),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Align(alignment: Alignment.bottomCenter, child: Bookings());
                                              });
                                        },
                                        child: Text(
                                          'See all(${snapshot.data!.orders!.length})',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 16, color: primaryColor, fontFamily: 'bold'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  data.orders!.isEmpty
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child: Text("No Booking"),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        )
                                      : SizedBox(
                                          height: (snapshot.data!.orders!.length > 3 ? 2 : snapshot.data!.orders!.length) * 80,
                                          child: ListView.builder(
                                              itemCount: snapshot.data!.orders!.length,
                                              // physics:
                                              //     NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, listIndex) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: SwipeCard(order: snapshot.data!.orders![listIndex]),
                                                );
                                              }),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: bodyColor,
                              thickness: 3.5,
                              height: 50,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: hor_Size),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Nearby',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 15, color: thirdColor, fontFamily: 'bold'),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => NearbyPage(
                                                        nearby: data.nearby,
                                                      )));
                                        },
                                        child: Text(
                                          'See all(${snapshot.data!.nearby!.length})',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 16, color: primaryColor, fontFamily: 'bold'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  data.nearby!.isEmpty
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child: Text("No Nearby"),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        )
                                      : SizedBox(
                                          height: (snapshot.data!.nearby!.length > 3 ? 2 : 180),
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshot.data!.nearby!.length,
                                              // physics:
                                              //     NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, listIndex) {
                                                return NearbyCard(
                                                  marchantDetail: data.nearby![listIndex],
                                                  // featured: index < 3 ? true : false,
                                                  leftPadding: standardPadding,
                                                  rightPadding: standardPadding,
                                                );
                                              }),
                                        ),
                                ],
                              ),
                            ),
                            Divider(
                              color: bodyColor,
                              thickness: 3,
                              height: 50,
                            ),
                            // Hor_Card_List(title: 'Nearby Locations')
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: CustomBackButton(),
                    )
                  ],
                ),
              );
            } else {
              return LoadingWidget();
            }
          }),
    );
  }
}

class ButtonsClick extends ConsumerStatefulWidget {
  MarchantDetail snapshot;
  MarchantService marchantProvider;
  String bookmark_ID;

  // int index;

  ButtonsClick({
    required this.snapshot,
    required this.bookmark_ID,
    // required this.index,
    required this.marchantProvider,
  });

  @override
  _ButtonsClickState createState() => _ButtonsClickState();
}

class _ButtonsClickState extends ConsumerState<ButtonsClick> {
  bool bookmark = false;
  String bookmarkId = "0";

  @override
  Widget build(BuildContext context) {
    final _bookmarkServiceInfoProvider = ref.watch(bookmarkProvider);

    return Material(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            rowIcons(FontAwesomeIcons.shareSquare, 'Share', () {
              Share.share('check out my website https://example.com');
            }),
            rowIcons(FontAwesomeIcons.star, 'Review', () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ReviewPage()));
            }),
            rowIcons(Icons.camera_alt, 'Photo', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AllPictureGrid(
                            avatar: widget.snapshot.avatar,
                            name: widget.snapshot.name,
                            reating: widget.marchantProvider.rating,
                          )));
            }),
            FutureBuilder<Map<String, dynamic>>(
              future: _bookmarkServiceInfoProvider.getBookmarkCategories(),
              builder: (context, snapshot) {
                log("${snapshot.data}", name: "Bookmark Data");
                if (snapshot.data?['status_code'] == true) {
                  final data = BookmarkData.fromJson(snapshot.data?['result']);
                  if (data.MarchantDetails1.any((element) => element.id == widget.snapshot.id) == true) {
                    log("True", name: "Already Bookmarked");
                    bookmark = true;
                    bookmarkId = _bookmarkServiceInfoProvider.BookMarkData.MarchantDetails1
                        .where((element) => element.id == widget.snapshot.id)
                        .first
                        .bookmarkId;
                  }
                  return rowIcons(
                    bookmark == true ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
                    'Bookmark',
                    () {
                      log("$bookmark", name: "Bookmark Value");
                      setState(
                        () {
                          if (bookmark == true) {
                            _bookmarkServiceInfoProvider.deleteBookmark(
                              context: context,
                              index: 0,
                              business_id: bookmarkId,
                            );
                            bookmark = false;
                          } else {
                            _bookmarkServiceInfoProvider.addBookmark(
                              context: context,
                              business_id: widget.snapshot.id!,
                            );
                            bookmark = true;
                          }
                        },
                      );
                    },
                  );
                }
                return rowIcons(
                  bookmark == true ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
                  'Bookmark',
                  () {
                    log("$bookmark", name: "Bookmark Value");

                    setState(
                      () {
                        if (bookmark == true) {
                          _bookmarkServiceInfoProvider.deleteBookmark(
                            context: context,
                            index: 0,
                            business_id: bookmarkId,
                          );
                          bookmark = false;
                        } else {
                          _bookmarkServiceInfoProvider.addBookmark(
                            context: context,
                            business_id: widget.snapshot.id!,
                          );
                          bookmark = true;
                        }
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget rowIcons(IconData icons, String title, VoidCallback onChnage) {
    return InkWell(
      onTap: onChnage,
      child: Column(
        children: [
          FaIcon(
            icons,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: thirdColor, fontFamily: 'bold'),
          ),
        ],
      ),
    );
  }
}

class Bookings extends ConsumerStatefulWidget {
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends ConsumerState<Bookings> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final _marchantProvider = ref.read(marchantProvider);

    return Container(
      height: size.height * 0.7,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration:
          BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Booking Orders",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder<MarchantDetail>(
              future: _marchantProvider.marchantDetail(),
              builder: (context, snap) {
                if (snap.hasData) {
                  return Expanded(
                    child: snap.data!.orders!.isEmpty
                        ? Center(
                            child: Text(
                              "No Bookings",
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          )
                        : ListView.builder(
                            itemCount: snap.data!.orders!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: SwipeCard(order: snap.data!.orders![index]),
                              );
                            }),
                  );
                }
                return LoadingWidget(
                  color: Colors.white,
                );
              }),
        ],
      ),
    );
  }
}
