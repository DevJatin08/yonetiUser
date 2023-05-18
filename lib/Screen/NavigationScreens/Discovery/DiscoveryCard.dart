import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/NearBy/NearbyDetails.dart';
import 'package:userapp/Screen/CommonWidgets/NetWorkImages.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/BrandDetails.dart';

class DiscoveyCard extends HookConsumerWidget {
  bool? featured;
  double? width;
  double? leftPadding;
  double? rightPadding;

  Marchant marchantDetail;
  DiscoveyCard(
      {this.featured = false,
      this.width = 150,
      this.leftPadding = 0,
      this.rightPadding = 16,
      required this.marchantDetail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _marchantProvider = ref.watch(marchantProvider);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: leftPadding!, right: rightPadding!, top: 0, bottom: 20),
      child: InkWell(
        onTap: () async {
          await _marchantProvider.setMarchantId(marchantDetail.id!, "-0.0");
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
                      height: 90,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(cardRadius),
                              topRight: Radius.circular(cardRadius)),
                          color: thirdColor),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(cardRadius),
                            topRight: Radius.circular(cardRadius)),
                        child: NetworkImages(
                          url: marchantDetail.image!,
                        ),
                      ),
                    ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          marchantDetail.name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15, color: thirdColor, fontFamily: 'bold'),
                        ),
                        Text(
                          '${marchantDetail.address!}',
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
