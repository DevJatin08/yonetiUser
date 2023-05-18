import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Constant/InputStyle.dart';
import 'package:userapp/Model/Bookmark/BookmarkDetail.dart';
import 'package:userapp/Screen/CommonWidgets/Appbars/AppbarWithIcons.dart';
import 'package:userapp/Screen/CommonWidgets/Card/BookmarkCard.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/NavigationScreens/NearBy/Component/FilterPopup.dart';

class Bookmark extends ConsumerStatefulWidget {
  Bookmark({Key? key}) : super(key: key);

  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends ConsumerState<Bookmark> {
  var Alldata;
  bool _isLoading = true;
  bool Search = false;
  List<MarchantDetail1>? _usersDisplay = <MarchantDetail1>[];

  Future LoadingData() async {
    await ref.read(bookmarkProvider).getBookmarkCategories().then((value) {
      setState(() {
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
  }

  @override
  Widget build(BuildContext context) {
    final _bookmarkProvider = ref.watch(bookmarkProvider);

    return Scaffold(
      body: _isLoading
          ? LoadingWidget()
          : Column(
              children: [
                // Material(
                //   child: Padding(
                //     padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
                //     //  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                //     child: Container(
                //       child: Column(
                //         children: [
                //           Row(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Icon(
                //                 Icons.bookmark,
                //                 color: primaryColor,
                //               ),
                //               SizedBox(
                //                 width: 10,
                //               ),
                //               Text(
                //                 'Bookmark',
                //                 maxLines: 1,
                //                 overflow: TextOverflow.clip,
                //                 style: TextStyle(
                //                     fontFamily: 'bold',
                //                     fontSize: 32,
                //                     color: thirdColor),
                //               ),
                //             ],
                //           ),
                //           SizedBox(
                //             height: 10,
                //           ),
                //           TextFormField(
                //             decoration: transparentInputDecoration.copyWith(
                //                 isCollapsed: false,
                //                 prefixIcon: Icon(Icons.search),
                //                 hintText: 'Search for restaurant...',
                //                 hintStyle: TextStyle(
                //                     fontSize: 16,
                //                     color: Color(0xff9d9d9d),
                //                     fontFamily: 'bold'),
                //                 filled: true,
                //                 fillColor: Color(0xfff2f2f3)),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                AppbarWithIcon(
                  title: 'Bookmark',
                  onTap: () {
                    setState(() {
                      Search = true;
                    });
                  },
                  onChanged: (searchText) {
                    searchText = searchText.toLowerCase();
                    setState(() {
                      _usersDisplay = _bookmarkProvider
                          .BookMarkData.MarchantDetails1
                          .where((u) {
                        var fName = u.fullname.toLowerCase();
                        return fName.contains(searchText);
                      }).toList();
                    });
                  },
                  // onChanged: (val) {
                  //   Alldata = data!.marchantDetails!.where((element) {
                  //     final fullnameLower = element.fullname!.toLowerCase();
                  //     final searchLower = val.toLowerCase();
                  //
                  //     return fullnameLower.contains(searchLower);
                  //   }).toList();
                  //   setState(() {});
                  // },
                  icons: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return FilterPopup();
                              });
                        },
                        child: Icon(
                          Icons.filter_alt,
                          color: primaryColor,
                          size: 27,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Align(
                        //   alignment: Alignment.topRight,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(right: 10.0),
                        //     child: Text(
                        //       'Filter',
                        //       maxLines: 1,
                        //       overflow: TextOverflow.clip,
                        //       style: TextStyle(
                        //           fontFamily: 'bold',
                        //           fontSize: 16,
                        //           color: primaryColor),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        _bookmarkProvider.BookMarkData.MarchantDetails1.isEmpty
                            ? Expanded(
                                child: Center(
                                  child: Text("No Bookmark"),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    itemCount: Search
                                        ? _usersDisplay!.length
                                        : _bookmarkProvider.BookMarkData
                                            .MarchantDetails1.length,
                                    itemBuilder: (context, index) {
                                      return BookmarkCard(
                                        index: index,
                                        data: Search
                                            ? _usersDisplay
                                            : _bookmarkProvider
                                                .BookMarkData.MarchantDetails1,
                                      );
                                    })),
                      ],
                    ),
                  ),
                )
              ],
            ),
//     final _notificationInfoProvider = useProvider(bookmarkProvider);
//
//     return Scaffold(
//       body: FutureBuilder<BookmarkData>(
//           future: _notificationInfoProvider.getBookmarkCategories(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               final data = snapshot.data;
//               return Column(
//                 children: [
//                   // Material(
//                   //   child: Padding(
//                   //     padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
//                   //     //  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                   //     child: Container(
//                   //       child: Column(
//                   //         children: [
//                   //           Row(
//                   //             crossAxisAlignment: CrossAxisAlignment.center,
//                   //             children: [
//                   //               Icon(
//                   //                 Icons.bookmark,
//                   //                 color: primaryColor,
//                   //               ),
//                   //               SizedBox(
//                   //                 width: 10,
//                   //               ),
//                   //               Text(
//                   //                 'Bookmark',
//                   //                 maxLines: 1,
//                   //                 overflow: TextOverflow.clip,
//                   //                 style: TextStyle(
//                   //                     fontFamily: 'bold',
//                   //                     fontSize: 32,
//                   //                     color: thirdColor),
//                   //               ),
//                   //             ],
//                   //           ),
//                   //           SizedBox(
//                   //             height: 10,
//                   //           ),
//                   //           TextFormField(
//                   //             decoration: transparentInputDecoration.copyWith(
//                   //                 isCollapsed: false,
//                   //                 prefixIcon: Icon(Icons.search),
//                   //                 hintText: 'Search for restaurant...',
//                   //                 hintStyle: TextStyle(
//                   //                     fontSize: 16,
//                   //                     color: Color(0xff9d9d9d),
//                   //                     fontFamily: 'bold'),
//                   //                 filled: true,
//                   //                 fillColor: Color(0xfff2f2f3)),
//                   //           )
//                   //         ],
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//
//                   AppbarWithIcon(
//                     title: 'Bookmark',
//                     onChange: (val) {
//                       final Alldata = data!.MarchantDetails1.where((element) {
//                         final fullnameLower = element.fullname.toLowerCase();
//                         final searchLower = val.toLowerCase();
//
//                         return fullnameLower.contains(searchLower);
//                       }).toList();
//                       setState(() {});
//                     },
//                     icons: Row(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return FilterPopup();
//                                 });
//                           },
//                           child: Icon(
//                             Icons.filter_alt,
//                             color: primaryColor,
//                             size: 27,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           // Align(
//                           //   alignment: Alignment.topRight,
//                           //   child: Padding(
//                           //     padding: const EdgeInsets.only(right: 10.0),
//                           //     child: Text(
//                           //       'Filter',
//                           //       maxLines: 1,
//                           //       overflow: TextOverflow.clip,
//                           //       style: TextStyle(
//                           //           fontFamily: 'bold',
//                           //           fontSize: 16,
//                           //           color: primaryColor),
//                           //     ),
//                           //   ),
//                           // ),
//                           // SizedBox(
//                           //   height: 5,
//                           // ),
//                           Expanded(
//                               child: ListView.builder(
//                                   itemCount: data!.MarchantDetails1.length,
//                                   itemBuilder: (context, index) {
//                                     return BookmarkCard(
//                                       index: index,
//                                       data: data,
//                                     );
//                                   })),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               );
//             }
//             return LoadingWidget();
//           }),
// >>>>>>> 3fb9658456f9505210502b808be8c8f9fe8c5a17
//     );
    );
  }
}
