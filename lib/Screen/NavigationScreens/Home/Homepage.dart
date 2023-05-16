import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Home/HomeAdsPackage.dart';
import 'package:userapp/Model/Home/HomeCategories.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/CommonWidgets/NetWorkImages.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/Notification.dart';
import 'package:userapp/Screen/NavigationScreens/NearBy/NearBy.dart';
import 'package:userapp/Services/Services/google_ads_service.dart';

String? userName;

class HomePage extends StatefulHookWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await context.read(notificationProvider).getCounter();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final _homeServiceInfoProvider = useProvider(homeServiceProvider);
    final _notificationProvider = useProvider(notificationProvider);
    return Scaffold(
      body: FutureBuilder<HomeCategories>(
          future: _homeServiceInfoProvider.getCategories(),
          builder: (context, snapshot) {
            log("${snapshot.connectionState}", name: "Connection State");
            if (snapshot.data?.username != null) {
              userName = snapshot.data?.username;
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data!.categories!.isEmpty
                  ? Center(
                      child: Text("No Category"),
                    )
                  : Column(
                      children: [
                        Material(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 10),
                            child: ListTile(
                              // visualDensity: VisualDensity(horizontal: -1, vertical: 0),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              trailing: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NotificationPopUp()));
                                },
                                child: Stack(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/SVG/bellicon.svg',
                                      width: 28,
                                      height: 28,
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.redAccent),
                                        child: Text(
                                          "${_notificationProvider.result.count}",
                                          style: TextStyle(
                                              fontSize: 9, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              leading: (snapshot.data!.avatar != null)
                                  ? Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: NetworkImages(
                                          url: snapshot.data!.avatar!,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              title: Row(
                                children: [
                                  Text(
                                    snapshot.data!.username!,
                                    style: TextStyle(
                                        fontSize: 20,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GridView.builder(
                                itemCount: snapshot.data!.categories!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () async {
                                      await _homeServiceInfoProvider
                                          .setCategoryData(
                                              snapshot
                                                  .data!.categories![index].id!,
                                              snapshot.data!.categories![index]
                                                  .name!);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => NearByScreen()));
                                    },
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: snapshot.data!
                                                .categories![index].image!,
                                            fit: BoxFit.fill,
                                            width: 80,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget: ((context, url,
                                                    error) =>
                                                const Center(
                                                    child: Icon(Icons.error))),
                                          ),
                                          // Image.network(
                                          //   "${snapshot.data!.categories![index].image}",
                                          //   width: 80,
                                          // ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${snapshot.data!.categories![index].name}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff173143),
                                                fontFamily: 'bold'),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${snapshot.data!.categories![index].cnt}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontFamily: 'bold'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        FutureBuilder<HomePackagesDetail>(
                            future: _homeServiceInfoProvider.getAdsPackages(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Container(
                                    height: 70,
                                    child: CarouselSlider.builder(
                                        itemCount: snapshot
                                            .data!.packagesDetails!.length,
                                        itemBuilder: (BuildContext context,
                                            int itemIndex, int pageViewIndex) {
                                          return InkWell(
                                            onTap: () {
                                              _homeServiceInfoProvider
                                                  .adsPackageRequests(
                                                      packageId: snapshot
                                                          .data!
                                                          .packagesDetails![
                                                              itemIndex]
                                                          .id!,
                                                      packageName: snapshot
                                                          .data!
                                                          .packagesDetails![
                                                              itemIndex]
                                                          .name!,
                                                      context: context);
                                            },
                                            child: Container(
                                              height: 70,
                                              width: 300,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(snapshot
                                                        .data!
                                                        .packagesDetails![
                                                            itemIndex]
                                                        .image!),
                                                    fit: BoxFit.fitHeight),
                                              ),
                                            ),
                                          );
                                        },
                                        options: CarouselOptions(
                                          height: 70,
                                          aspectRatio: 16 / 9,
                                          viewportFraction: 1,
                                          initialPage: 0,
                                          enableInfiniteScroll: true,
                                          reverse: false,
                                          autoPlay: true,
                                          autoPlayInterval:
                                              Duration(seconds: 3),
                                          autoPlayAnimationDuration:
                                              Duration(milliseconds: 800),
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          enlargeCenterPage: true,
                                          scrollDirection: Axis.horizontal,
                                        ))
                                    //  ListView.builder(
                                    //   itemCount:
                                    //       snapshot.data!.packagesDetails!.length,
                                    //   itemBuilder: (context, index) {
                                    //     return Container(
                                    //       height: 70,
                                    //       width: 300,
                                    //       padding:
                                    //           EdgeInsets.symmetric(vertical: 5),
                                    //       decoration: BoxDecoration(
                                    //         image: DecorationImage(
                                    //             image: NetworkImage(snapshot
                                    //                 .data!
                                    //                 .packagesDetails![index]
                                    //                 .image!),
                                    //             fit: BoxFit.fitHeight),
                                    //       ),
                                    //     );
                                    //   },
                                    // ),
                                    );
                              } else {
                                return SizedBox();
                              }
                            })
                        // _homeServiceInfoProvider
                      ],
                    );
            } else {
              return LoadingWidget();
            }
          }),
    );
  }
}
