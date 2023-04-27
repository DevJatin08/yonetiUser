import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Reviews/TopReviews.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/BrandDetails.dart';

class TopFindrCard extends HookWidget {
  int index;
  Review review;
  TopFindrCard({required this.index, required this.review});

  String defaultpic =
      "https://i0.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1";

  @override
  Widget build(BuildContext context) {
    final _merchantProvider = useProvider(marchantProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          // _merchantProvider.setMarchantId("${review.id}", "-0.00");
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => BrandDetail()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8, top: 10, left: 12, right: 12),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          review.image.toString(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              defaultpic,
                              color: Colors.grey,
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
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 20, color: thirdColor, fontFamily: 'bold'),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${review.totalReviews} Reviews, ${review.totalPhotos} Photos',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12, color: cardSubTextColor, fontFamily: 'bold'),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            review.ratingCategory!.rating(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                // color: (index + 1) % 2 == 0
                                //     ? Color(0xffcdd614)
                                //     : primaryColor,
                                color: primaryColor,
                                fontFamily: 'bold'),
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(20),
                              color: !review.isFollow! ? primaryColor : Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: Text(
                              'Follow',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: !review.isFollow! ? primaryColor : Colors.black,
                                  fontFamily: 'bold'),
                            ),
                          ),
                        ),
                        Text(
                          '#${review.rank}',
                          style: TextStyle(
                              fontSize: 22,
                              color: (index + 1) % 2 == 0 ? Color(0xffcdd614) : primaryColor,
                              fontFamily: 'bold'),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
