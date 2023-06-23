import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Bookmark/BookmarkDetail.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/BrandDetails.dart';
import 'package:userapp/Services/Services/MarchantService.dart';

class BookmarkCard extends HookConsumerWidget {
  List<MarchantDetail1>? data;
  int index;
  BookmarkCard({required this.data, required this.index});

  String defaultavtar =
      "https://unwomen.org.au/wp-content/uploads/2020/09/Avitar_Image_Placeholder-1.png";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _merchantProvider = ref.watch(marchantProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          _merchantProvider.setMarchantId(
              "${data![index].id}", "${data![index].rating}");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BrandDetail(
                        // index: index,
                        bookmark_id: data![index].bookmarkId.toString(),
                      )));
        },
        child: Material(
          borderRadius: BorderRadius.circular(5),
          elevation: listCardElevation,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
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
                            // color: thirdColor,
                            image: DecorationImage(
                                image: data![index].avatar.isNotEmpty
                                    ? NetworkImage("${data![index].avatar}")
                                    : NetworkImage(defaultavtar),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // '${DateFormat('hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(int.parse(data![index].businessStartTime)))} To ${DateFormat('hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(int.parse(data![index].businessCloseTime)))}',
                              '${data![index].businessStartTime} To ${data![index].businessCloseTime}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: cardSubTextColor,
                                  fontFamily: 'bold'),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '${data![index].fullname}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: thirdColor,
                                  fontFamily: 'bold'),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              ' ${data![index].address}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: cardSubTextColor,
                                  fontFamily: 'bold'),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              ' ${data![index].businessDetails}'
                                  .split('()')
                                  .first,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: cardSubTextColor,
                                  fontFamily: 'bold'),
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(cardRadius),
                                    bottomLeft: Radius.circular(cardRadius)),
                                color: primaryColor),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: Text(
                                ' ${data![index].rating}',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'bold'),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.bookmark,
                            color: primaryColor,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
