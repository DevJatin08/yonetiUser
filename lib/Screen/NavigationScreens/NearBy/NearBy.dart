import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Home/HomeMerchantList.dart';
import 'package:userapp/Screen/CommonWidgets/Appbars/AppbarWithIcons.dart';
import 'package:userapp/Screen/CommonWidgets/Card/GridViewCard.dart';
import 'package:userapp/Screen/CommonWidgets/Card/ListViewCard.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/NavigationScreens/NearBy/Component/FilterPopup.dart';

class NearByScreen extends ConsumerStatefulWidget {
  NearByScreen();

  @override
  _NearByScreenState createState() => _NearByScreenState();
}

class _NearByScreenState extends ConsumerState<NearByScreen> {
  bool gridView = true;

  List<MarchantDetail>? _users = <MarchantDetail>[];
  List<MarchantDetail>? _usersDisplay = <MarchantDetail>[];
  bool _isLoading = true;
  bool Search = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadingData(ref);
  }

  Future LoadingData(WidgetRef ref) async {
    // await context.read(homeServiceProvider).getMerchantList();
    await ref.read(homeServiceProvider).getMerchantList();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _homeServiceInfoProvider = ref.watch(homeServiceProvider);
    final double itemWidth = size.width / 2.3;
    double cardWidth = MediaQuery.of(context).size.width / 3.3;
    double cardHeight = MediaQuery.of(context).size.height / 3.6;
    print('-----$_isLoading----');
    return Scaffold(
        body: _isLoading
            ? LoadingWidget()
            : _homeServiceInfoProvider
                    .homeMerchantCategory.marchantDetails!.isEmpty
                ? Center(
                    child: Text("No data"),
                  )
                : SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppbarWithIcon(
                          backButton: true,
                          title:
                              '${_homeServiceInfoProvider.categoryName} - Nearby',
                          onTap: () {
                            setState(() {
                              Search = true;
                            });
                          },
                          onChanged: (searchText) {
                            searchText = searchText.toLowerCase();
                            setState(() {
                              _usersDisplay = _homeServiceInfoProvider
                                  .homeMerchantCategory.marchantDetails!
                                  .where((u) {
                                var fName = u.fullname!.toLowerCase();

                                _usersDisplay!.addAll(_homeServiceInfoProvider
                                    .homeMerchantCategory.marchantDetails!
                                    .toList());
                                return fName.contains(searchText);
                              }).toList();
                            });
                          },
                          icons: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return FilterPopup();
                                      });
                                },
                                child: Icon(
                                  Icons.filter_alt,
                                  color: primaryColor,
                                  size: 27,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    gridView = !gridView;
                                  });
                                },
                                child: Icon(
                                  Icons.bento,
                                  color: primaryColor,
                                  size: 27,
                                ),
                              )
                            ],
                          ),
                          icosubIcons: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff173143),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: Text(
                                '1823',
                                style:
                                    TextStyle(fontSize: 9, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: gridView
                                ? Search
                                    ? _usersDisplay!.isEmpty
                                        ? Center(
                                            child: Text("No Data"),
                                          )
                                        : GridView.builder(
                                            itemCount: Search
                                                ? _usersDisplay!.length
                                                : _homeServiceInfoProvider
                                                    .homeMerchantCategory
                                                    .marchantDetails!
                                                    .length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio:
                                                        (itemWidth /
                                                            gridCardHeight),
                                                    crossAxisCount: 2),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return new GridViewCard(
                                                marchantDetail: Search
                                                    ? _usersDisplay![index]
                                                    : _homeServiceInfoProvider
                                                        .homeMerchantCategory
                                                        .marchantDetails![index],
                                                // featured: index < 3 ? true : false,
                                                leftPadding: standardPadding,
                                                rightPadding: standardPadding,
                                              );
                                            },
                                          )
                                    : GridView.builder(
                                        itemCount: Search
                                            ? _usersDisplay!.length
                                            : _homeServiceInfoProvider
                                                .homeMerchantCategory
                                                .marchantDetails!
                                                .length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: (itemWidth /
                                                    gridCardHeight),
                                                crossAxisCount: 2),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return new GridViewCard(
                                            marchantDetail: Search
                                                ? _usersDisplay![index]
                                                : _homeServiceInfoProvider
                                                    .homeMerchantCategory
                                                    .marchantDetails![index],
                                            // featured: index < 3 ? true : false,
                                            leftPadding: standardPadding,
                                            rightPadding: standardPadding,
                                          );
                                        },
                                      )
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    child: Search
                                        ? _usersDisplay!.isEmpty
                                            ? Center(
                                                child: Text("No Data"),
                                              )
                                            : ListView.builder(
                                                itemCount: Search
                                                    ? _usersDisplay!.length
                                                    : _homeServiceInfoProvider
                                                        .homeMerchantCategory
                                                        .marchantDetails!
                                                        .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    child: new ListViewCard(
                                                      marchantDetail: Search
                                                          ? _usersDisplay![
                                                              index]
                                                          : _homeServiceInfoProvider
                                                              .homeMerchantCategory
                                                              .marchantDetails![index],
                                                    ),
                                                  );
                                                },
                                              )
                                        : ListView.builder(
                                            itemCount: Search
                                                ? _usersDisplay!.length
                                                : _homeServiceInfoProvider
                                                    .homeMerchantCategory
                                                    .marchantDetails!
                                                    .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                child: new ListViewCard(
                                                  marchantDetail: Search
                                                      ? _usersDisplay![index]
                                                      : _homeServiceInfoProvider
                                                          .homeMerchantCategory
                                                          .marchantDetails![index],
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ));
  }
}
