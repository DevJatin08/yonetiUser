import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Model/Marchant/MarchantDetail.dart';
import 'package:userapp/Model/Reviews/SeeAllReview.dart';

class ReviewCards extends StatefulWidget {
  bool? isBottomdivider;
  List<Reviews>? reviews;
  int index;
  ReviewCards(
      {this.isBottomdivider = true,
      required this.reviews,
      required this.index});

  @override
  _ReviewCardsState createState() => _ReviewCardsState();
}

class _ReviewCardsState extends State<ReviewCards> {
  bool showAll = false;
  final length = 150;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: thirdColor),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.reviews![widget.index].name!.isEmpty ? "null" : widget.reviews![widget.index].name}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: thirdColor,
                              fontSize: 16,
                              fontFamily: 'bold'),
                        ),
                        Text(
                          '${widget.reviews!.length} Reviews',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: cardSubTextColor,
                              fontSize: 12,
                              fontFamily: 'bold'),
                        ),
                      ],
                    ),
                  )
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
                      Text(
                        'Rated',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: cardSubTextColor,
                            fontSize: 12,
                            fontFamily: 'bold'),
                      ),
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
                  Text(
                    'find 1 Days ago',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: cardSubTextColor,
                        fontSize: 12,
                        fontFamily: 'bold'),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text.rich(TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: widget.reviews![widget.index].comments!.length >
                                length &&
                            !showAll
                        ? widget.reviews![widget.index].comments!
                                .substring(0, length) +
                            "..."
                        : widget.reviews![widget.index].comments!,
                    style: TextStyle(
                      color: thirdColor, fontSize: 16,
                      //  fontFamily: 'medium'
                    ),
                  ),
                  widget.reviews![widget.index].comments!.length > length
                      ? WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showAll = !showAll;
                              });
                            },
                            child: Text(
                              showAll ? 'read less' : 'read more!',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        )
                      : TextSpan(),
                ],
              )),
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
