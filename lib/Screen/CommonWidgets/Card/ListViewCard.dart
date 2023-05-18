import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Home/HomeMerchantList.dart';
import 'package:userapp/Screen/CommonWidgets/NetWorkImages.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/BrandDetails.dart';

class ListViewCard extends HookConsumerWidget {
  MarchantDetail marchantDetail;

  ListViewCard({required this.marchantDetail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _marchantProvider = ref.watch(marchantProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: standardPadding, vertical: 4),
      child: InkWell(
        onTap: () async {
          await _marchantProvider.setMarchantId(marchantDetail.id!, marchantDetail.rating!);
          Navigator.push(context, MaterialPageRoute(builder: (_) => BrandDetail()));
        },
        child: Material(
          borderRadius: BorderRadius.circular(5),
          elevation: listCardElevation,
          child: Container(
            height: 110,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: EdgeInsets.only(bottom: 8, top: 8, left: 10),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 94,
                        width: 94,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: thirdColor,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(cardRadius), topRight: Radius.circular(cardRadius)),
                          child: NetworkImages(
                            url: marchantDetail.avatar!,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${marchantDetail.businessStartTime}Am to ${marchantDetail.businessCloseTime}Pm',
                              style: TextStyle(fontSize: 12, color: cardSubTextColor, fontFamily: 'bold'),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              marchantDetail.fullname!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 18, color: thirdColor, fontFamily: 'bold'),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              marchantDetail.address!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12, color: cardSubTextColor, fontFamily: 'bold'),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              marchantDetail.businessDetails!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12, color: cardSubTextColor, fontFamily: 'bold'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  marchantDetail.rating! != "0.00"
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child:
                                //  index < 3
                                //     ? Container(
                                //         decoration: BoxDecoration(
                                //             borderRadius: BorderRadius.only(
                                //                 topLeft: Radius.circular(cardRadius),
                                //                 bottomLeft: Radius.circular(cardRadius)),
                                //             color: featureBackground),
                                //         child: Padding(
                                //           padding: const EdgeInsets.symmetric(
                                //               horizontal: 8, vertical: 2),
                                //           child: Text(
                                //             'Featured',
                                //             style: TextStyle(
                                //                 fontSize: 10,
                                //                 color: Colors.white,
                                //                 fontFamily: 'bold'),
                                //           ),
                                //         ),
                                //       )
                                //     :
                                Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(cardRadius), bottomLeft: Radius.circular(cardRadius)),
                                  color: primaryColor),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                child: Text(
                                  marchantDetail.rating!,
                                  style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'bold'),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
