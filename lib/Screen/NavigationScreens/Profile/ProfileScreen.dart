import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Constant/InputStyle.dart';
import 'package:userapp/Model/Order/ActiveOrder.dart';
import 'package:userapp/Screen/CommonWidgets/CustomButton.dart';
import 'package:userapp/Screen/CommonWidgets/EditField.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/CommonWidgets/Snackbar.dart';
import 'package:userapp/Screen/NavigationScreens/Order/OrderDetail.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/Components/OptionsBottomSheet.dart';
import 'package:userapp/Services/Services/ImagePickerConvertor.dart';
import 'package:userapp/Services/Services/UserService.dart';
import 'package:userapp/main.dart';

class ProfileScreen extends StatefulHookWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller = TabController(length: 2, vsync: this);
  TextEditingController tab1 = TextEditingController();
  TextEditingController tab2 = TextEditingController();
  TextEditingController tab3 = TextEditingController();
  ScrollController scrollController = ScrollController();
  ScrollController listController = ScrollController();
  bool listControllerInitialzed = false;
  bool stickyTitle = false;
  int selectedIndex = -1;
  double fixPixel = 320;
  List tabName = ['Active Bookings', 'Past Bookings'];
  String defaultCover =
      'https://1080motion.com/wp-content/uploads/2018/06/NoImageFound.jpg.png';

  bool _isLoading = true;

  void editTap() {
    setState(() {
      tabName[0] = tab1.text;
      tabName[1] = tab2.text;

      Navigator.pop(context);
    });
  }

  Future LoadingData() async {
    await context.read(orderProvider).activeOrder().then((value) {
      setState(() {
        print('called loaingData');
        _isLoading = false;
        //print(_usersDisplay.length);
      });
    });
    await context.read(orderProvider).pastOrder().then((value) {
      setState(() {
        print('called loaingData');
        _isLoading = false;
        //print(_usersDisplay.length);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadingData();
    _controller.addListener(() {
      setState(() {});
    });
    // scrollController.addListener(() {
    //   // print(scrollController.position.pixels);
    //   if (scrollController.position.pixels > fixPixel) {
    //     setState(() {
    //       // stickyTitle = true;
    //       // scrollController.jumpTo(scrollController.position.minScrollExtent);
    //     });
    //   }
    // });
    // listController.addListener(() {
    //   if (stickyTitle) if (!listControllerInitialzed) {
    //     setState(() {
    //       listControllerInitialzed = true;
    //     });
    //   } else {
    //     if (listController.position.pixels == 0.0 && listControllerInitialzed) {
    //       setState(() {
    //         // stickyTitle = false;
    //         // scrollController.jumpTo(fixPixel);
    //       });
    //     }
    //   }
    // });
  }

  // List<Booking>? _usersDisplay = <Booking>[];
  // bool Search = false;
  @override
  Widget build(BuildContext context) {
    final double sideSpacing = 0.075;
    final size = MediaQuery.of(context).size;
    final userProvider = useProvider(userInfoProvider);
    final _orderProvider = useProvider(orderProvider);
    log("${jsonEncode(_orderProvider.pastOrderList)}",
        name: "Past Booking Data");
    return SafeArea(
      child: _isLoading
          ? LoadingWidget()
          : Column(
              children: [
                Container(
                  color: Color(0xfff4f4f4),
                  height: size.height * .07,
                  child: Padding(
                    padding: EdgeInsets.only(left: size.width * .05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          userProvider.userData.email.toString(),
                          style: TextStyle(color: thirdColor),
                        ),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return OptionsBottomSheet();
                                  });
                            },
                            icon: Icon(Icons.menu_outlined, color: thirdColor))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    height: size.height,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      // physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 300,
                            // height: 350,
                            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    coverBottomSheet(
                                        'Update Cover', userProvider);
                                  },
                                  child: Container(
                                    width: size.width,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              defaultCover,
                                            ),
                                            fit: BoxFit.cover)),
                                    child: Image.network(
                                      userProvider.userData.coverPhoto
                                          .toString(),
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.network(
                                          defaultCover,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      // loadingBuilder: (context, child, loadingProgress) {
                                      //   return loadingWidget();
                                      // },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: sideSpacing * size.width,
                                  top: 130,
                                  child: Container(
                                    width: size.width * 0.85,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 155,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: primaryColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                        // Container(
                                        //   height: 50,
                                        //   width: size.width * .6,
                                        //   decoration: BoxDecoration(
                                        //     color: primaryColor,
                                        //     borderRadius: BorderRadius.only(
                                        //       bottomLeft: Radius.circular(20),
                                        //       bottomRight: Radius.circular(20),
                                        //     ),
                                        //   ),
                                        //   child: Row(
                                        //     children: [
                                        //       Expanded(
                                        //           child: Column(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.center,
                                        //         children: [
                                        //           Text(
                                        //             "${ userProvider.userData.}",
                                        //             style: TextStyle(
                                        //                 color: Colors.white,
                                        //                 fontFamily: 'bold',
                                        //                 fontSize: 22),
                                        //           ),
                                        //           Text(
                                        //             "Reviews",
                                        //             style: TextStyle(
                                        //                 color: Colors.white,
                                        //                 fontWeight:
                                        //                     FontWeight.w400,
                                        //                 fontSize: 10),
                                        //           )
                                        //         ],
                                        //       )),
                                        //       Expanded(
                                        //           child: Column(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.center,
                                        //         children: [
                                        //           Text(
                                        //             "258",
                                        //             style: TextStyle(
                                        //                 color: Colors.white,
                                        //                 fontFamily: 'bold',
                                        //                 fontSize: 22),
                                        //           ),
                                        //           Text(
                                        //             "Bookmarks",
                                        //             style: TextStyle(
                                        //                 color: Colors.white,
                                        //                 fontWeight:
                                        //                     FontWeight.w400,
                                        //                 fontSize: 10),
                                        //           )
                                        //         ],
                                        //       )),
                                        //       Expanded(
                                        //           child: Column(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.center,
                                        //         children: [
                                        //           Text(
                                        //             "300",
                                        //             style: TextStyle(
                                        //                 color: Colors.white,
                                        //                 fontFamily: 'bold',
                                        //                 fontSize: 22),
                                        //           ),
                                        //           Text(
                                        //             "Likes",
                                        //             style: TextStyle(
                                        //                 color: Colors.white,
                                        //                 fontWeight:
                                        //                     FontWeight.w400,
                                        //                 fontSize: 10),
                                        //           )
                                        //         ],
                                        //       )),
                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),

                                Positioned(
                                    left: size.width * .075,
                                    top: 70,
                                    child: Container(
                                      // color: Colors.teal,
                                      // width: size.width * .7,
                                      // height: size.height * .25,
                                      height: 200,
                                      width: size.width * .85,

                                      // decoration: BoxDecoration(
                                      //   color: Colors.transparent,
                                      //   border: Border.all(
                                      //     color: secondaryColor,
                                      //   ),
                                      //   borderRadius: BorderRadius.circular(25),
                                      // ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * .04),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 120,
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      avatarBottomSheet(
                                                          'Avatar',
                                                          userProvider);
                                                    },
                                                    child: Container(
                                                      width: 110,
                                                      height: 120,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Image.network(
                                                          userProvider
                                                              .userData.avatar
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image
                                                                .network(
                                                              defaultCover,
                                                              fit: BoxFit.cover,
                                                            );
                                                          },
                                                          // loadingBuilder: (context, child,
                                                          //     loadingProgress) {
                                                          //   return loadingWidget();
                                                          // },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          userProvider
                                                              .userData.fullname
                                                              .toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff42566d),
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  'bold',
                                                              letterSpacing: 1),
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          userProvider
                                                              .userData.fullname
                                                              .toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: thirdColor,
                                                              fontSize: 10,
                                                              letterSpacing:
                                                                  .5),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height: 45,
                                              child: Text(
                                                userProvider.userData.userBio
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff3d526a),
                                                    letterSpacing: 1),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            // Align(
                                            //   alignment: Alignment.center,
                                            //   child: Row(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.center,
                                            //     children: [
                                            //       Icon(
                                            //         Icons.launch_outlined,
                                            //         size: 12,
                                            //         color: primaryColor,
                                            //       ),
                                            //       Text(
                                            //         userProvider
                                            //             .userData.website
                                            //             .toString(),
                                            //         style: TextStyle(
                                            //             fontSize: 14,
                                            //             color: thirdColor),
                                            //         textAlign: TextAlign.center,
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    )),
                                // Positioned(
                                //   left: size.width * .15,
                                //   top: size.height * .2,
                                //   child: Container(
                                //     width: size.width * .18,
                                //     height: size.height * .15,
                                //     color: Colors.teal,
                                //   ),
                                // )
                              ],
                            ),
                          ),
                          // if (!stickyTitle)
                          //   Container(
                          //     height: 350,
                          //     // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                          //     child: Stack(
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             coverBottomSheet('Update cover', userProvider);
                          //           },
                          //           child: Container(
                          //             width: size.width,
                          //             height: 200,
                          //             decoration: BoxDecoration(
                          //                 image: DecorationImage(
                          //                     image: NetworkImage(
                          //                       defaultCover,
                          //                     ),
                          //                     fit: BoxFit.cover)),
                          //             child: Image.network(
                          //               userProvider.userData.coverPhoto.toString(),
                          //               fit: BoxFit.cover,
                          //               errorBuilder: (context, error, stackTrace) {
                          //                 return Image.network(
                          //                   defaultCover,
                          //                   fit: BoxFit.cover,
                          //                 );
                          //               },
                          //               // loadingBuilder: (context, child, loadingProgress) {
                          //               //   return loadingWidget();
                          //               // },
                          //             ),
                          //           ),
                          //         ),
                          //         Positioned(
                          //           left: sideSpacing * size.width,
                          //           top: 130,
                          //           child: Container(
                          //             width: size.width * 0.85,
                          //             child: Column(
                          //               children: [
                          //                 Container(
                          //                   height: 155,
                          //                   decoration: BoxDecoration(
                          //                     color: Colors.white,
                          //                     border: Border.all(
                          //                       color: primaryColor,
                          //                     ),
                          //                     borderRadius: BorderRadius.circular(25),
                          //                   ),
                          //                 ),
                          //                 Container(
                          //                   height: 50,
                          //                   width: size.width * .6,
                          //                   decoration: BoxDecoration(
                          //                     color: primaryColor,
                          //                     borderRadius: BorderRadius.only(
                          //                       bottomLeft: Radius.circular(20),
                          //                       bottomRight: Radius.circular(20),
                          //                     ),
                          //                   ),
                          //                   child: Row(
                          //                     children: [
                          //                       Expanded(
                          //                           child: Column(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.center,
                          //                         children: [
                          //                           Text(
                          //                             "758",
                          //                             style: TextStyle(
                          //                                 color: Colors.white,
                          //                                 fontFamily: 'bold',
                          //                                 fontSize: 22),
                          //                           ),
                          //                           Text(
                          //                             "Reviews",
                          //                             style: TextStyle(
                          //                                 color: Colors.white,
                          //                                 fontWeight: FontWeight.w400,
                          //                                 fontSize: 10),
                          //                           )
                          //                         ],
                          //                       )),
                          //                       Expanded(
                          //                           child: Column(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.center,
                          //                         children: [
                          //                           Text(
                          //                             "258",
                          //                             style: TextStyle(
                          //                                 color: Colors.white,
                          //                                 fontFamily: 'bold',
                          //                                 fontSize: 22),
                          //                           ),
                          //                           Text(
                          //                             "Bookmarks",
                          //                             style: TextStyle(
                          //                                 color: Colors.white,
                          //                                 fontWeight: FontWeight.w400,
                          //                                 fontSize: 10),
                          //                           )
                          //                         ],
                          //                       )),
                          //                       Expanded(
                          //                           child: Column(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.center,
                          //                         children: [
                          //                           Text(
                          //                             "300",
                          //                             style: TextStyle(
                          //                                 color: Colors.white,
                          //                                 fontFamily: 'bold',
                          //                                 fontSize: 22),
                          //                           ),
                          //                           Text(
                          //                             "Likes",
                          //                             style: TextStyle(
                          //                                 color: Colors.white,
                          //                                 fontWeight: FontWeight.w400,
                          //                                 fontSize: 10),
                          //                           )
                          //                         ],
                          //                       )),
                          //                     ],
                          //                   ),
                          //                 )
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //
                          //         Positioned(
                          //             left: size.width * .075,
                          //             top: 70,
                          //             child: Container(
                          //               // color: Colors.teal,
                          //               // width: size.width * .7,
                          //               // height: size.height * .25,
                          //               height: 200,
                          //               width: size.width * .85,
                          //
                          //               // decoration: BoxDecoration(
                          //               //   color: Colors.transparent,
                          //               //   border: Border.all(
                          //               //     color: secondaryColor,
                          //               //   ),
                          //               //   borderRadius: BorderRadius.circular(25),
                          //               // ),
                          //               child: Padding(
                          //                 padding: EdgeInsets.symmetric(
                          //                     horizontal: size.width * .04),
                          //                 child: Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.center,
                          //                   children: [
                          //                     Container(
                          //                       height: 120,
                          //                       child: Row(
                          //                         children: [
                          //                           InkWell(
                          //                             onTap: () {
                          //                               avatarBottomSheet(
                          //                                   'Update Avater',
                          //                                   userProvider);
                          //                             },
                          //                             child: Container(
                          //                               width: 110,
                          //                               height: 120,
                          //                               decoration: BoxDecoration(
                          //
                          //                                   // image: DecorationImage(
                          //                                   //     fit: BoxFit.cover,
                          //                                   //     image: NetworkImage(
                          //                                   //       "https://images.unsplash.com/photo-1524230616393-d6229fcd2eff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
                          //                                   //     )),
                          //                                   borderRadius:
                          //                                       BorderRadius.circular(
                          //                                           10)),
                          //                               child: ClipRRect(
                          //                                 borderRadius:
                          //                                     BorderRadius.circular(
                          //                                         10),
                          //                                 child: NetworkImages(
                          //                                   url: userProvider
                          //                                       .userData.avatar!,
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                           ),
                          //                           SizedBox(
                          //                             width: 10,
                          //                           ),
                          //                           Expanded(
                          //                             child: Column(
                          //                               mainAxisAlignment:
                          //                                   MainAxisAlignment.end,
                          //                               crossAxisAlignment:
                          //                                   CrossAxisAlignment.start,
                          //                               children: [
                          //                                 Text(
                          //                                   userProvider
                          //                                       .userData.fullname!,
                          //                                   maxLines: 1,
                          //                                   overflow:
                          //                                       TextOverflow.ellipsis,
                          //                                   style: TextStyle(
                          //                                       color:
                          //                                           Color(0xff42566d),
                          //                                       fontSize: 24,
                          //                                       fontFamily: 'bold',
                          //                                       letterSpacing: 1),
                          //                                 ),
                          //                                 SizedBox(
                          //                                   height: 2,
                          //                                 ),
                          //                                 Text(
                          //                                   "58 Noel street, London UK",
                          //                                   maxLines: 1,
                          //                                   overflow:
                          //                                       TextOverflow.ellipsis,
                          //                                   style: TextStyle(
                          //                                       color: thirdColor,
                          //                                       fontSize: 10,
                          //                                       letterSpacing: .5),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           )
                          //                         ],
                          //                       ),
                          //                     ),
                          //                     SizedBox(
                          //                       height: 8,
                          //                     ),
                          //                     Container(
                          //                       height: 45,
                          //                       child: Text(
                          //                         userProvider.userData.userBio ?? "",
                          //                         style: TextStyle(
                          //                             fontSize: 12,
                          //                             color: Color(0xff3d526a),
                          //                             letterSpacing: 1),
                          //                         maxLines: 3,
                          //                         overflow: TextOverflow.ellipsis,
                          //                         textAlign: TextAlign.center,
                          //                       ),
                          //                     ),
                          //                     SizedBox(
                          //                       height: 8,
                          //                     ),
                          //                     Align(
                          //                       alignment: Alignment.center,
                          //                       child: Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.center,
                          //                         children: [
                          //                           Icon(
                          //                             Icons.launch_outlined,
                          //                             size: 12,
                          //                             color: thirdColor,
                          //                           ),
                          //                           Text(
                          //                             userProvider.userData.website ??
                          //                                 "",
                          //                             style: TextStyle(
                          //                                 fontSize: 14,
                          //                                 color: thirdColor),
                          //                             textAlign: TextAlign.center,
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             )),
                          //         // Positioned(
                          //         //   left: size.width * .15,
                          //         //   top: size.height * .2,
                          //         //   child: Container(
                          //         //     width: size.width * .18,
                          //         //     height: size.height * .15,
                          //         //     color: Colors.teal,
                          //         //   ),
                          //         // )
                          //       ],
                          //     ),
                          //   ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .075),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: primaryColor, width: 1),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: SizedBox(
                                    height: 30,
                                    child: TabBar(
                                      labelStyle: TextStyle(color: Colors.teal),

                                      // indicatorColor: Colors.teal,
                                      isScrollable: false,
                                      labelColor: Colors.white,
                                      unselectedLabelColor: primaryColor,

                                      indicator: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        // border: Border.all(color: borderColor, width: 2),
                                      ),
                                      indicatorPadding: EdgeInsets.all(0),
                                      indicatorSize: TabBarIndicatorSize.tab,

                                      controller: _controller,
                                      // automaticIndicatorColorAdjustment: false,
                                      labelPadding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),

                                      tabs: [
                                        Tab(
                                          // text: "tab 1",
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 0),
                                            child: Text(
                                              tabName[0],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontFamily: 'bold',
                                                  fontSize: size.width * 0.035),
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          // text: "tab 1",
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 0),
                                            child: Center(
                                              child: Text(
                                                tabName[1],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontFamily: 'bold',
                                                    fontSize:
                                                        size.width * 0.035),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _controller.index == 1
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: size.width * 0.075),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: TextFormField(
                                              // onTap: () {
                                              //   setState(() {
                                              //     Search = true;
                                              //   });
                                              // },
                                              // onChanged: (searchText) {
                                              //   searchText =
                                              //       searchText.toLowerCase();
                                              //   setState(() {
                                              //     _usersDisplay = _orderProvider
                                              //         .pastOrderList
                                              //         .pastBooking!
                                              //         .where((u) {
                                              //       var orderDetails = u
                                              //           .orderDetails!
                                              //           .toLowerCase();
                                              //       return orderDetails
                                              //           .contains(searchText);
                                              //     }).toList();
                                              //   });
                                              // },
                                              decoration: InputDecoration(
                                        isCollapsed: true,
                                        suffixIcon: Icon(
                                          Icons.search,
                                          color: cardSubTextColor,
                                        ),
                                        suffixIconConstraints: BoxConstraints(
                                            maxWidth: 50,
                                            maxHeight: 50,
                                            minWidth: 50,
                                            minHeight: 40),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: Color(0xffd8d8d8),
                                                width: 1)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: Color(0xffd8d8d8),
                                                width: 1)),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: Color(0xffd8d8d8),
                                                width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: Color(0xffd8d8d8),
                                                width: 1)),
                                      ))),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      // InkWell(
                                      //   onTap: () {
                                      //     showModalBottomSheet(
                                      //         isScrollControlled: false,
                                      //         context: context,
                                      //         builder: (context) {
                                      //           return Schedule();
                                      //         });
                                      //   },
                                      //   child: Image.asset(
                                      //     'assets/images/filter.png',
                                      //     color: primaryColor,
                                      //     width: 30,
                                      //     height: 30,
                                      //   ),
                                      // )
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 10,
                          ),
                          if (_controller.index == 0)
                            _orderProvider.activtOrderList.orders!.isEmpty
                                ? Container(
                                    height: size.height / 3,
                                    child:
                                        Center(child: Text("No Active Order")))
                                : Container(
                                    height: 90 *
                                        (_controller.index == 0
                                                ? _orderProvider.activtOrderList
                                                    .orders!.length
                                                // : Search
                                                //     ? _usersDisplay!.length
                                                : _orderProvider.pastOrderList
                                                    .pastBooking!.length)
                                            .toDouble(),
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        controller: listController,
                                        itemCount: _orderProvider
                                            .activtOrderList.orders!.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                selectedIndex == index ? 0 : 20,
                                                8,
                                                20,
                                                8),
                                            child: GestureDetector(
                                                onHorizontalDragUpdate: (v) {
                                                  if (v.delta.dx.isNegative) {
                                                    setState(() {
                                                      selectedIndex = index;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      selectedIndex = -1;
                                                    });
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: card(_orderProvider
                                                          .activtOrderList
                                                          .orders![index]),
                                                    ),
                                                    selectedIndex == index
                                                        ? InkWell(
                                                            onTap: () {
                                                              log("jcbdhjcvdjhcv" +
                                                                  _orderProvider
                                                                      .activtOrderList
                                                                      .orders![
                                                                          index]
                                                                      .toString());
                                                              log("jcbdhjcvdjhcv ==" +
                                                                  _orderProvider
                                                                      .activtOrderList
                                                                      .orders![
                                                                          index]
                                                                      .orderId
                                                                      .toString());

                                                              showModalBottomSheet(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Container(
                                                                        child:
                                                                            OrderDetail(
                                                                      booking: _orderProvider
                                                                          .activtOrderList
                                                                          .orders![index],
                                                                      Order_id: _orderProvider
                                                                          .activtOrderList
                                                                          .orders![
                                                                              index]
                                                                          .orderId,
                                                                    ));
                                                                  });
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          8),
                                                              child: Icon(
                                                                _controller.index ==
                                                                        0
                                                                    ? Icons.sync
                                                                    : Icons
                                                                        .article,
                                                                color:
                                                                    cardSubTextColor,
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox()
                                                  ],
                                                )),
                                          );
                                        }),
                                  ),
                          if (_controller.index == 1)
                            _orderProvider.pastOrderList.pastBooking!.isEmpty
                                ? Container(
                                    height: size.height / 4,
                                    child: Center(
                                      child: Text("No Past Order"),
                                    ),
                                  )
                                : Container(
                                    height: 90 *
                                        _orderProvider
                                            .pastOrderList.pastBooking!.length
                                            .toDouble(),
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        // controller: listController,
                                        itemCount:
                                            // Search
                                            //     ? _usersDisplay!.length
                                            //     :
                                            _orderProvider.pastOrderList
                                                .pastBooking!.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                selectedIndex == index ? 0 : 20,
                                                8,
                                                20,
                                                8),
                                            child: GestureDetector(
                                                onHorizontalDragUpdate: (v) {
                                                  if (v.delta.dx.isNegative) {
                                                    setState(() {
                                                      selectedIndex = index;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      selectedIndex = -1;
                                                    });
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: card(
                                                        // Search
                                                        // ? _usersDisplay![index]
                                                        // :
                                                        _orderProvider
                                                                .pastOrderList
                                                                .pastBooking![
                                                            index],
                                                      ),
                                                    ),
                                                    selectedIndex == index
                                                        ? InkWell(
                                                            onTap: () {
                                                              log("${_orderProvider.pastOrderList.pastBooking}",
                                                                  name:
                                                                      "Past Booking Index");
                                                              showModalBottomSheet(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Container(
                                                                        child:
                                                                            PastOrderDetails(
                                                                      // booking: _orderProvider
                                                                      //     .activtOrderList
                                                                      //     .orders![index],
                                                                      Order_id: _orderProvider
                                                                          .pastOrderList
                                                                          .pastBooking![
                                                                              index]
                                                                          .orderId,
                                                                    ));
                                                                  });
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          8),
                                                              child: Icon(
                                                                _controller.index ==
                                                                        0
                                                                    ? Icons
                                                                        .settings
                                                                    : Icons
                                                                        .article,
                                                                color:
                                                                    cardSubTextColor,
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox()
                                                  ],
                                                )),
                                          );
                                        })),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget card(Booking booking) {
    final size = MediaQuery.of(context).size;

    return Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(cardRadius),
      child: Container(
        height: 70,
        width: size.width,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(cardRadius)),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(cardRadius),
                        topLeft: Radius.circular(cardRadius)),
                    color: primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      booking.bookingDate != null
                          ? "${setMonth(int.parse(booking.bookingDate!.split('-')[1]))},${booking.bookingDate!.split('-').last}"
                          : "${booking.date}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontFamily: 'bold'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.orderDetails!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13,
                            color: thirdColor,
                            fontFamily: 'bold'),
                      ),
                      Text(
                        'Service',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            color: cardSubTextColor,
                            fontFamily: 'bold'),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        '2406 E 8th St, Los Angeles',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            color: cardSubTextColor,
                            fontFamily: 'bold'),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        child: Text(
                          booking.orderId!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, fontFamily: 'bold'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    booking.amount != null
                        ? Text(
                            '\$${booking.amount}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'bold',
                                color: cardSubTextColor),
                          )
                        : SizedBox(),
                  ],
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget imagePop(
    String title,
    VoidCallback tap1,
    VoidCallback tap2,
  ) {
    final size = MediaQuery.of(context).size;
    return Material(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontFamily: 'bold'),
            ),
            Divider(
              color: thirdColor,
              height: 30,
              thickness: 2,
            ),
            InkWell(
                onTap: tap1,
                child: Container(
                  width: size.width,
                  child: Text(
                    'Camera',
                    // style: TextStyle(fontSize: 18, fontFamily: 'bold'),
                  ),
                )),
            Divider(
              color: customField,
              height: 20,
            ),
            InkWell(
                onTap: tap2,
                child: Container(
                  width: size.width,
                  child: Text(
                    'Gallery',
                    // style: TextStyle(fontSize: 18, fontFamily: 'bold'),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void avatarBottomSheet(String title, UserService _userProvider) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return imagePop('Update avatar Photo', () async {
            await ImagePickerAndConvertor()
                .pickImage(ImageSource.camera)
                .then((value) async {
              poploading(context);
              final res = await _userProvider.updateAvatar(value);
              if (res.statusCode!) {
                await apiCall.sendNotification(
                  title: "Profile Image",
                  body: "Your Profile Image is Updated",
                  to: fcmToken!,
                );
              }
              snackbar(res.message!, context);
              Navigator.pop(context);
            });
          }, () async {
            await ImagePickerAndConvertor()
                .pickImage(ImageSource.gallery)
                .then((value) async {
              poploading(context);
              final res = await _userProvider.updateAvatar(value);
              if (res.statusCode!) {
                await apiCall.sendNotification(
                  title: "Profile Image",
                  body: "Your Profile Image is Updated",
                  to: fcmToken!,
                );
              }
              snackbar(res.message!, context);
              Navigator.pop(context);
              Navigator.pop(context);
            });
          });
        });
  }

  void coverBottomSheet(String title, UserService _userProvider) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return imagePop('${title} Photo', () async {
            await ImagePickerAndConvertor()
                .pickImage(ImageSource.camera)
                .then((value) async {
              poploading(context);
              final res = await _userProvider.updateCover(value);

              snackbar(res.message!, context);
              Navigator.pop(context);
            });
          }, () async {
            await ImagePickerAndConvertor()
                .pickImage(ImageSource.gallery)
                .then((value) async {
              poploading(context);
              final res = await _userProvider.updateCover(value);

              snackbar(res.message!, context);
              Navigator.pop(context);
              Navigator.pop(context);
            });
          });
        });
  }
}

List<String> images = [
  "https://images.unsplash.com/photo-1559599101-f09722fb4948?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1469&q=80",
  "https://images.unsplash.com/photo-1516975080664-ed2fc6a32937?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1470&q=80",
  "https://images.unsplash.com/photo-1560066984-138dadb4c035?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1974&q=80",
  "https://images.unsplash.com/photo-1580618672591-eb180b1a973f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1469&q=80",
  "https://images.unsplash.com/photo-1559599101-f09722fb4948?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1469&q=80",
  "https://images.unsplash.com/photo-1516975080664-ed2fc6a32937?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1470&q=80",
  "https://images.unsplash.com/photo-1560066984-138dadb4c035?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1974&q=80",
  "https://images.unsplash.com/photo-1580618672591-eb180b1a973f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1469&q=80",
];

class EditTabPopUp extends StatelessWidget {
  TextEditingController tab1;
  TextEditingController tab2;
  TextEditingController tab3;
  VoidCallback callBack;

  EditTabPopUp(
      {required this.tab1,
      required this.tab2,
      required this.tab3,
      required this.callBack});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Edit Tabs",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        Divider(
          color: Color(0xfff2f2f3),
          thickness: 2,
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              EditableTextField(
                controller: tab1,
                label: 'Tab 1',
                hint: 'Tab 1',
                suffix: false,
                inputDecoration: transparentInputDecoration,
              ),
              SizedBox(
                height: 10,
              ),
              EditableTextField(
                controller: tab2,
                label: 'Tab 2',
                hint: 'Tab 2',
                suffix: false,
                inputDecoration: transparentInputDecoration,
              ),
              SizedBox(
                height: 10,
              ),
              EditableTextField(
                controller: tab3,
                label: 'Tab 3',
                hint: 'Tab 3',
                suffix: false,
                inputDecoration: transparentInputDecoration,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  text: 'Edit Tabs',
                  voidCallback: callBack,
                  color: primaryColor)
            ],
          ),
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final Widget _tabBar;

  @override
  double get minExtent => 100;

  @override
  double get maxExtent => 100;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
