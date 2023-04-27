import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:userapp/Model/Reviews/TopReviews.dart';
import 'package:userapp/Screen/CommonWidgets/Card/TopFindrCard.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Services/Services/TopYoneti.dart';

class TopReview extends StatefulHookWidget {
  @override
  State<TopReview> createState() => _TopReviewState();
}

class _TopReviewState extends State<TopReview> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TopReviews>(
        future: TopYoneti().topReviews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            revielenth = snapshot.hasData ? snapshot.data!.reviews!.length : 0;
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.reviews!.length,
                    itemBuilder: (context, index) {
                      log("${jsonEncode(snapshot.data)}", name: "Top Review");
                      return snapshot.data!.reviews![index].id != null
                          ? TopFindrCard(
                              index: index,
                              review: snapshot.data!.reviews![index],
                            )
                          : SizedBox();
                    },
                  )
                : Center(
                    child: Text("No Reviews"),
                  );
          } else {
            return LoadingWidget();
          }
        });
  }
}

int revielenth = 0;
