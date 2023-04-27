import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Reviews/SeeAllReview.dart';
import 'package:userapp/Screen/CommonWidgets/Appbars/Appbar.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/NavigationScreens/Components/Review/ReviewCard.dart';

class ReviewPage extends StatefulHookWidget {
  ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController controller = TextEditingController();
  ValueNotifier reviewRate = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    final _marchantProvider = useProvider(marchantProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppbarWithoutIcon(title: 'Review'),
            Divider(
              color: bodyColor,
              thickness: 3,
              height: 10,
            ),
            Expanded(
              child: FutureBuilder<ReviewData>(
                  future: _marchantProvider.GetAllReviwe(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data;
                      return data!.allReviews.isEmpty
                          ? Center(
                              child: Text(
                                "No Reviews",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "bold",
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: data.allReviews.length,
                              itemBuilder: (context, index) {
                                return ReviewCard(
                                  index: index,
                                  reviews: data.allReviews,
                                  isBottomdivider: index < 2 ? true : false,
                                );
                              },
                            );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    return LoadingWidget();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
