import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Home/HomeMerchantList.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/BrandDetails.dart';

class GridViewCard extends HookConsumerWidget {
  bool? featured;
  double? width;
  double? leftPadding;
  double? rightPadding;

  MarchantDetail marchantDetail;
  GridViewCard(
      {this.featured = false,
      this.width = 150,
      this.leftPadding = 0,
      this.rightPadding = 16,
      required this.marchantDetail});

  String defaultpic =
      "https://i0.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _marchantProvider = ref.watch(marchantProvider);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: leftPadding!, right: rightPadding!, top: 0, bottom: 20),
      child: InkWell(
        onTap: () async {
          print("After Id " + marchantDetail.id.toString());
          await _marchantProvider.setMarchantId(marchantDetail.id!, marchantDetail.rating!);

          Navigator.push(context, MaterialPageRoute(builder: (_) => BrandDetail()));
        },
        child: Material(
          elevation: listCardElevation,
          borderRadius: BorderRadius.circular(cardRadius),
          child: Container(
            height: gridCardHeight,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cardRadius),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      width: size.width,
                      height: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(cardRadius),
                              topRight: Radius.circular(cardRadius)),
                          color: Colors.white),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(cardRadius),
                            topRight: Radius.circular(cardRadius)),
                        child: Image.network(
                          marchantDetail.avatar.toString(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              defaultpic,
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
                    // Container(
                    //   height: 90,
                    //   width: size.width,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.only(
                    //           topLeft: Radius.circular(cardRadius),
                    //           topRight: Radius.circular(cardRadius)),
                    //       color: Colors.white
                    //   ),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.only(
                    //         topLeft: Radius.circular(cardRadius),
                    //         topRight: Radius.circular(cardRadius)),
                    //     child: NetworkImages(
                    //       url: marchantDetail.avatar!,
                    //     ),
                    //   ),
                    // ),
                    featured!
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(cardRadius),
                                        bottomLeft: Radius.circular(cardRadius)),
                                    color: featureBackground),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  child: Text(
                                    'Featured',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white, fontFamily: 'bold'),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          marchantDetail.fullname!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15, color: thirdColor, fontFamily: 'bold'),
                        ),
                        Text(
                          '${marchantDetail.address!} \n ${marchantDetail.businessDetails!}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 13, color: cardSubTextColor, fontFamily: 'bold'),
                        ),
                        // Text(
                        //   'Hair Saloon',
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: TextStyle(
                        //       fontSize: 13,
                        //       color: cardSubTextColor,
                        //       fontFamily: 'bold'),
                        // )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
