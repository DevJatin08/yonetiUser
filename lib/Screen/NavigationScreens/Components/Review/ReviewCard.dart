import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/timeAgo.dart';
import 'package:userapp/Model/Reviews/SeeAllReview.dart';

class ReviewCard extends StatefulWidget {
  bool? isBottomdivider;
  List<AllReview>? reviews;
  int index;

  ReviewCard({this.isBottomdivider = true, required this.reviews, required this.index});

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool showAll = false;
  final length = 150;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.reviews![widget.index].avatar.trim().isNotEmpty
                              ? widget.reviews![widget.index].avatar
                              : "https://i0.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1",
                        ),
                        fit: BoxFit.cover,
                      ),
                      color: thirdColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${widget.reviews![widget.index].reviewedBy.isEmpty ? "null" : widget.reviews![widget.index].reviewedBy}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: thirdColor, fontSize: 16, fontFamily: 'bold'),
                  ),
                  Spacer(),
                  Text(
                    timeAgo(widget.reviews![widget.index].date),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: cardSubTextColor, fontSize: 12, fontFamily: 'bold'),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Text(
                      //   'Rated',
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(color: cardSubTextColor, fontSize: 12, fontFamily: 'bold'),
                      // ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      // Container(
                      //   width: 80,
                      //   height: 15,
                      //   child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: 5,
                      //       itemBuilder: (context, index) {
                      //         return Icon(
                      //           Icons.star_outline,
                      //           size: 15,
                      //           color: Color(0xffcdd614),
                      //         );
                      //       }),
                      // ),
                      // SizedBox(
                      //   width: 3,
                      // ),
                      // Text(
                      //   '4.0',
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //       color: Color(0xffcdd614),
                      //       fontSize: 12,
                      //       fontFamily: 'bold'),
                      // ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: widget.reviews![widget.index].comments.length > length && !showAll
                          ? widget.reviews![widget.index].comments.substring(0, length) + "..."
                          : widget.reviews![widget.index].comments,
                      style: TextStyle(
                        color: thirdColor, fontSize: 16,
                        //  fontFamily: 'medium'
                      ),
                    ),
                    widget.reviews![widget.index].comments.length > length
                        ? WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  showAll = !showAll;
                                });
                              },
                              child: Text(
                                showAll ? 'Read less' : 'Read more!',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          )
                        : TextSpan(),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        if (widget.isBottomdivider!)
          Divider(
            color: bodyColor,
            thickness: 2,
            height: 30,
          ),
      ],
    );
  }
}
