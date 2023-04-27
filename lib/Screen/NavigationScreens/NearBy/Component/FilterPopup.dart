import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Screen/CommonWidgets/CustomButton.dart';

class FilterPopup extends StatefulHookWidget {
  const FilterPopup({Key? key}) : super(key: key);

  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  late LocationData _locationData;
  late double lat;
  late double long;
  Location location = new Location();
  getlocation() async {
    _locationData = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      lat = currentLocation.latitude!;
      long = currentLocation.longitude!;
     context.read(filterProvider).getFilter(
          opennow: 0,
          lat: lat,
          long: long,
          rateing: 0,
          nearest: 0,
          cost_low_to_high: 0,
          cost_high_to_low: 0,
          homeservice: 0);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getlocation();
    super.initState();
  }

  final filterHeight = 0.05;
  final filterIcon = 0.04;
  List<bool> quickFilter = [
    true,
    false,
    false,
  ];
  List<bool> sortby = [
    true,
    false,
    false,
  ];
  List<bool> listby = [
    true,
  ];
  @override
  Widget build(BuildContext context) {
    final _filterProvider = useProvider(filterProvider);

    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
      child: Material(
        borderRadius: BorderRadius.circular(cardRadius),
        color: Colors.transparent,
        child: SingleChildScrollView(
            child: Container(
          width: size.width,
          // height: size.height * 0.85,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(cardRadius)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Filter',
                          style: TextStyle(
                              color: thirdColor,
                              fontFamily: 'bold',
                              fontSize: 20),
                        ),
                        Text(
                          'Trending',
                          style: TextStyle(
                              color: cardSubTextColor,
                              fontFamily: 'bold',
                              fontSize: 12),
                        )
                      ],
                    ),
                    Text(
                      'Reset',
                      style: TextStyle(
                          color: primaryColor,
                          fontFamily: 'bold',
                          fontSize: 16),
                    )
                  ],
                ),
                Divider(
                  color: Color(0xfff2f2f3),
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Quick filter',
                  style: TextStyle(
                      color: cardSubTextColor,
                      fontFamily: 'bold',
                      fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                quickFilterWidget(0, 'Open now', size),
                quickFilterWidget(1, 'Rated 4+', size),
                quickFilterWidget(2, 'Rated 3+', size),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Sorted by',
                  style: TextStyle(
                      color: cardSubTextColor,
                      fontFamily: 'bold',
                      fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                sortedByWidget(0, 'Nearest to me', size),
                sortedByWidget(1, 'Cost high to low', size),
                sortedByWidget(2, 'Cost low to high', size),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'List by',
                  style: TextStyle(
                      color: cardSubTextColor,
                      fontFamily: 'bold',
                      fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                listByWidget(0, 'Home Service', size),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'Apply',
                  voidCallback: () {
                    _filterProvider.getFilter(
                        opennow: quickFilter[0] == true ? 1 : 0,
                        rateing: quickFilter[1] == true ? 1 : 0,
                        lat: lat,
                        long: long,
                        nearest: sortby[0] == true ? 1 : 0,
                        cost_low_to_high: sortby[1] == true ? 1 : 0,
                        cost_high_to_low: sortby[2] == true ? 1 : 0,
                        homeservice: listby[0] == true ? 1 : 0);
                    Navigator.pop(context);
                  },
                  fontSize: 16,
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget quickFilterWidget(int index, String title, Size size) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: thirdColor, fontSize: 16),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  quickFilter[index] = !quickFilter[index];
                });
              },
              child: Container(
                width: size.width * filterHeight,
                height: size.width * filterHeight,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: quickFilter[index]
                            ? primaryColor
                            : cardSubTextColor,
                        width: 2)),
                child: Center(
                  child: Icon(
                    Icons.done,
                    color: quickFilter[index] ? primaryColor : cardSubTextColor,
                    size: size.width * filterIcon,
                  ),
                ),
              ),
            ),
          ],
        ),
        divider(size)
      ],
    );
  }

  Widget sortedByWidget(int index, String title, Size size) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: thirdColor, fontSize: 16),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  sortby[index] = !sortby[index];
                });
              },
              child: Container(
                width: size.width * filterHeight,
                height: size.width * filterHeight,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: sortby[index] ? primaryColor : cardSubTextColor,
                        width: 2)),
                child: Center(
                  child: Icon(
                    Icons.done,
                    color: sortby[index] ? primaryColor : cardSubTextColor,
                    size: size.width * filterIcon,
                  ),
                ),
              ),
            ),
          ],
        ),
        divider(size)
      ],
    );
  }

  Widget listByWidget(int index, String title, Size size) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: thirdColor, fontSize: 16),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  listby[index] = !listby[index];
                });
              },
              child: Container(
                width: size.width * filterHeight,
                height: size.width * filterHeight,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: listby[index] ? primaryColor : cardSubTextColor,
                        width: 2)),
                child: Center(
                  child: Icon(
                    Icons.done,
                    color: listby[index] ? primaryColor : cardSubTextColor,
                    size: size.width * filterIcon,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget divider(Size size) {
    return Divider(
      color: Color(0xfff2f2f3),
      height: size.height * 0.04,
      thickness: 2,
    );
  }
}
