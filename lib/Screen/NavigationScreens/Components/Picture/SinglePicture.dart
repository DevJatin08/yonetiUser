import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Comment/GetCommentDetail.dart';
import 'package:userapp/Model/Like/likeDetail.dart';
import 'package:userapp/Screen/CommonWidgets/Popup.dart';
import 'package:userapp/Screen/NavigationScreens/Components/Picture/Component/PostComment.dart';
import 'package:userapp/Screen/NavigationScreens/Components/Picture/Component/PostLikes.dart';
import 'package:userapp/Screen/NavigationScreens/Components/Picture/Component/PostPopup.dart';

class SinglePicture extends ConsumerStatefulWidget {
  String? image;
  String? id;
  String? name;
  String? user_profile;
  String? merchant_id;

  SinglePicture(
      {this.image, this.user_profile, this.id, this.name, this.merchant_id});

  @override
  _SinglePictureState createState() => _SinglePictureState();
}

class _SinglePictureState extends ConsumerState<SinglePicture> {
  List like = [];
  String imagenotfound = "https://www.alldaydr.com/app/images/no_image.png";
  String isLiked = '0';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _getcommentProvider = ref.watch(getcommentProvider);
    final _getlikeProvider = ref.watch(getlikedataProvider);
    final _marchantProvider = ref.watch(marchantProvider);
    final userInfo = ref.watch(userInfoProvider);
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Photo",
          style: TextStyle(
            fontSize: 20,
            color: thirdColor,
            fontFamily: 'bold',
          ),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              // visualDensity: VisualDensity(horizontal: -1, vertical: 0),
              // contentPadding: EdgeInsets.only(left: 10),
              trailing: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return PostPopUp(
                          showdelete: false,
                          showedit: false,
                          height: 110,
                          link: widget.image,
                        );
                      });
                },
                child: Icon(
                  Icons.more_horiz_outlined,
                  color: Colors.black,
                ),
              ),
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                  widget.user_profile != null
                      ? widget.user_profile!
                      : "https://i0.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1",
                ),
              ),
              title: Row(
                children: [
                  Text(
                    widget.name!,
                    style: TextStyle(fontSize: 16, fontFamily: 'bold'),
                  ),
                ],
              ),
              subtitle: Text(
                "1 days ago",
                style: TextStyle(
                    fontSize: 12, color: Color(0xff9d9d9d), fontFamily: 'bold'),
              ),
            ),
            Container(
              height: size.height * 0.45,
              width: size.width * 1,
              child: widget.image!.isEmpty
                  ? Image.network(imagenotfound)
                  : Image.network(
                      "${widget.image}",
                      fit: BoxFit.fill,
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FutureBuilder<GetLikeData>(
                          future: _getlikeProvider.getLikeData(
                              ImageID: widget.id.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data;

                              isLiked = (data != null &&
                                      data.flag != null &&
                                      data.flag != 'null')
                                  ? data.flag
                                  : '0';
                              return isLiked == '1'
                                  ? InkWell(
                                      onTap: () {
                                        _marchantProvider.addLike(
                                          image_id: widget.id.toString(),
                                          merchantId: widget.merchant_id,
                                          imageUrl: widget.image,
                                        );

                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.blue,
                                        size: 24,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        _marchantProvider.addLike(
                                          image_id: widget.id.toString(),
                                          merchantId: widget.merchant_id,
                                          imageUrl: widget.image,
                                        );
                                        setState(() {});
                                      },
                                      child: Image.asset(
                                        'assets/images/heart.png',
                                        color: Colors.blue,
                                        width: 24,
                                        height: 24,
                                      ),
                                    );
                            } else {
                              return InkWell(
                                onTap: () {
                                  _marchantProvider.addLike(
                                    image_id: widget.id.toString(),
                                    merchantId: widget.merchant_id,
                                    imageUrl: widget.image,
                                  );
                                  setState(() {});
                                },
                                child: Image.asset(
                                  'assets/images/heart.png',
                                  color: Colors.blue,
                                  width: 24,
                                  height: 24,
                                ),
                              );
                            }
                          }),
                      // InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       _marchantProvider.addLike(
                      //         image_id: widget.id.toString(),
                      //         merchantId: widget.merchant_id,
                      //         imageUrl: widget.image,
                      //       );
                      //     });
                      //   },
                      //   child: Image.asset(
                      //     'assets/images/heart.png',
                      //     color: Colors.blue,
                      //     width: 24,
                      //     height: 24,
                      //   ),
                      // ),
                      // FutureBuilder<LikeData>(
                      //     future: _marchantProvider.addLike(
                      //         image_id: widget.id.toString()),
                      //     builder: (context, snapshot) {
                      //       return InkWell(
                      //         onTap: () {
                      //           // customPopUp(
                      //           //     context,
                      //           //     PostLikes(
                      //           //       ImagId: widget.id,
                      //           //     ));
                      //         },
                      //         child: Image.asset(
                      //           'assets/images/heart.png',
                      //           color: Colors.blue,
                      //           width: 24,
                      //           height: 24,
                      //         ),
                      //       );
                      //     }),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          customPopUp(
                              context,
                              PostComment(
                                merchantId: widget.merchant_id,
                                imageUrl: widget.image,
                                ImageID: widget.id,
                              ));
                        },
                        child: Image.asset(
                          'assets/images/bubble-chat.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () async {
                          Directory tempDir = await getTemporaryDirectory();
                          final path = '${tempDir.path}/image.jpg';

                          await Dio().download(widget.image!, path);

                          Share.shareFiles([path]).then(
                            (value) => _marchantProvider.shareImage(
                              marchant_id: widget.merchant_id!,
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/share.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      FutureBuilder<GetLikeData>(
                          future: _getlikeProvider.getLikeData(
                              ImageID: widget.id.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data;
                              return GestureDetector(
                                onTap: () {
                                  customPopUp(
                                    context,
                                    PostLikes(
                                      ImagId: widget.id,
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent,
                                  ),
                                  child: Center(
                                      child: Text(
                                    "${data!.likeUsers.length} likes",
                                    style: TextStyle(
                                        color: Color(0xff9d9d9d),
                                        fontSize: 16,
                                        fontFamily: 'bold'),
                                  )),
                                ),
                              );
                            }
                            return Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.transparent,
                              ),
                              child: Center(
                                  child: Text(
                                "0 likes",
                                style: TextStyle(
                                    color: Color(0xff9d9d9d),
                                    fontSize: 16,
                                    fontFamily: 'bold'),
                              )),
                            );
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      FutureBuilder<GetCommentData>(
                          future: _getcommentProvider.getCommentData(
                              ImageID: widget.id.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data;
                              return GestureDetector(
                                onTap: () {
                                  // showDialog(context: context, builder: (context){
                                  //   return  PostComment();
                                  // });
                                  customPopUp(
                                      context,
                                      PostComment(
                                          merchantId:
                                              _marchantProvider.marchantId,
                                          imageUrl: widget.image,
                                          ImageID: widget.id));
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent,
                                  ),
                                  child: Center(
                                      child: Text(
                                    "${data!.comments.length} Comments",
                                    style: TextStyle(
                                        color: Color(0xff9d9d9d),
                                        fontSize: 16,
                                        fontFamily: 'bold'),
                                  )),
                                ),
                              );
                            }
                            return Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.transparent,
                              ),
                              child: Center(
                                  child: Text(
                                "0 Comments",
                                style: TextStyle(
                                    color: Color(0xff9d9d9d),
                                    fontSize: 16,
                                    fontFamily: 'bold'),
                              )),
                            );
                          }),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
