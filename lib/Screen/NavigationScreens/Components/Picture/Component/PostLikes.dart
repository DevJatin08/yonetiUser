import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Like/likeDetail.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';

class PostLikes extends HookWidget {
  String? ImagId;
  PostLikes({Key? key, this.ImagId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _getlikeProvider = useProvider(getlikedataProvider);

    return Container(
      width: size.width * .9,
      height: size.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[100],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: FutureBuilder<GetLikeData>(
          future: _getlikeProvider.getLikeData(ImageID: ImagId.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${data!.likeUsers.length} Likes",
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'bold', color: thirdColor),
                  ),
                  Text(
                    "Photos",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff9d9d9d),
                        fontFamily: 'bold'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(color: Colors.grey, height: 0),
                  Expanded(
                    child: data.likeUsers.isEmpty
                        ? Center(
                            child: Text("No Likes"),
                          )
                        : ListView.builder(
                            itemCount: data.likeUsers.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                            "${data.likeUsers[index].avatar}"),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${data.likeUsers[index].userName}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff173143),
                                                fontFamily: 'bold',
                                              ),
                                            ),
                                            Text(
                                              "45 Reviews,",
                                              style: TextStyle(
                                                  height: 1.5,
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontFamily: 'bold'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(color: Colors.grey, height: 0),
                                ],
                              );
                            },
                          ),
                  ),
                ],
              );
            }
            return LoadingWidget();
          },
        ),
      ),
    );
  }
}
