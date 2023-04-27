import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/TopPhotos/TopPhotosDetail.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/NavigationScreens/Components/Picture/SinglePicture.dart';
import 'package:userapp/Services/api_client/APICall.dart';

class TopPhotos extends HookWidget {
  String imagenotfound = "https://www.alldaydr.com/app/images/no_image.png";

  @override
  Widget build(BuildContext context) {
    final _topphotosProvider = useProvider(topphotosProvider);
    final _userInfoProvider = useProvider(userInfoProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<TopPhotosData>(
        future: _topphotosProvider.getTopPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              if (data!.photos!.isNotEmpty) {
                return GridView.builder(
                  itemCount: data.photos!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                      child: InkWell(
                        onTap: () async {
                          await APICall().apiGetProfile(data.photos![index].user_id!).then(
                            (value) {
                              log(
                                "$value",
                                name: "Profile Info",
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SinglePicture(
                                    image: data.photos?[index].image,
                                    id: data.photos?[index].id,
                                    name: value["result"]["fullname"],
                                    merchant_id: value["result"]["user_id"],
                                    user_profile: value["result"]["avatar"],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: data.photos![index].image != null
                            ? Container(
                                // height: 50,
                                // width: 50,
                                decoration: BoxDecoration(
                                    // color: thirdColor,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          data.photos![index].image.toString(),
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(cardRadius)),
                              )
                            : Container(
                                // height: 50,
                                // width: 50,
                                decoration: BoxDecoration(
                                  // color: thirdColor,
                                  image: DecorationImage(image: NetworkImage(imagenotfound), fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(cardRadius),
                                ),
                              ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text("No Photos"),
                );
              }
            } else {
              return Center(
                child: Text("No Photos"),
              );
            }
          } else {
            return LoadingWidget();
          }
        },
      ),
    );
  }
}
