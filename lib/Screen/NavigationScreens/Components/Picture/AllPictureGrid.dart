import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Album/Allalbum.dart';
import 'package:userapp/Model/Album/AllalbumuserDetail.dart';
import 'package:userapp/Model/Album/GetImages.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/NavigationScreens/Components/Picture/SinglePicture.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/Components/BackGroundScreen.dart';

class AllPictureGrid extends StatefulHookWidget {
  String? name;
  String? reating;
  String? avatar;

  AllPictureGrid({Key? key, this.name, this.reating, this.avatar}) : super(key: key);

  @override
  _AllPictureGridState createState() => _AllPictureGridState();
}

class _AllPictureGridState extends State<AllPictureGrid> {
  // List<String> gridList = ['All', 'Tab1', 'Tab2', 'Tab3'];
  int selectCategory = 0;
  String albumID = '';

  @override
  Widget build(BuildContext context) {
    final _merchantProvider = useProvider(marchantProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BackGroundScreen(
            avatar: widget.avatar,
          ),
          Container(
            height: size.height * stackBodyHeight,
            width: size.width,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(hor_padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${widget.name}",
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
                            '${widget.reating}',
                            style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'bold'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: bodyColor,
                  thickness: 3,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 42,
                  child: FutureBuilder<Allalbumuser>(
                      future: _merchantProvider.getCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data;
                          print(data);
                          return data!.albumName.isEmpty
                              ? Center(
                                  child: Text("No Data"),
                                )
                              : ListView.builder(
                                  itemCount: data.albumName.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (index != 0) {
                                            albumID = data.albumName[index].id;
                                            print("dsadsad" + albumID);
                                          } else {
                                            albumID = '';
                                          }
                                          selectCategory = index;
                                        });
                                      },
                                      child: Container(
                                        width: size.width / data.albumName.length,
                                        child: Column(
                                          children: [
                                            Text(
                                              data.albumName[index].name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 16, color: selectCategory == index ? primaryColor : thirdColor, fontFamily: 'bold'),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "${data.albumName[index].imgCnt}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12, color: selectCategory == index ? primaryColor : cardSubTextColor, fontFamily: 'bold'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                        }
                        return LoadingWidget();
                      }),
                ),
                Divider(
                  color: bodyColor,
                  thickness: 3,
                ),
                selectCategory == 0
                    ? Expanded(
                        child: FutureBuilder<AllalbumData>(
                            future: _merchantProvider.getCategories1(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final data = snapshot.data;
                                print(data!.images);
                                return data.images.isEmpty
                                    ? Center(
                                        child: Text("No Albums"),
                                      )
                                    : GridView.builder(
                                        itemCount: data.images.length,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                        itemBuilder: (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => SinglePicture(
                                                      id: data.images[index].id,
                                                      name: widget.name,
                                                      image: data.images[index].name,
                                                      merchant_id: data.images.first.userId,
                                                      user_profile: widget.avatar,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: new Container(
                                                // height: 50,
                                                // width: 50,
                                                decoration: BoxDecoration(
                                                    color: thirdColor,
                                                    image: DecorationImage(image: NetworkImage(data.images[index].name), fit: BoxFit.cover),
                                                    borderRadius: BorderRadius.circular(cardRadius)),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                              }
                              return LoadingWidget();
                            }),
                      )
                    : Expanded(
                        child: FutureBuilder<ImageData>(
                            future: _merchantProvider.getimageCategories(albumId: albumID),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final data = snapshot.data;
                                print(data!.images);
                                return data.images.isEmpty
                                    ? Center(
                                        child: Text("No Albums"),
                                      )
                                    : GridView.builder(
                                        itemCount: data.images.length,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                        itemBuilder: (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) => SinglePicture(
                                                              id: data.images[index].id,
                                                              name: widget.name,
                                                              image: data.images[index].name,
                                                            )));
                                              },
                                              child: new Container(
                                                // height: 50,
                                                // width: 50,
                                                decoration: BoxDecoration(
                                                    color: thirdColor,
                                                    image: DecorationImage(image: NetworkImage(data.images[index].name), fit: BoxFit.cover),
                                                    borderRadius: BorderRadius.circular(cardRadius)),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                              }
                              return LoadingWidget();
                            }),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
