import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/NearBy/NearbyDetails.dart';
import 'package:userapp/Screen/CommonWidgets/Appbars/AppbarWithIcons.dart';
import 'package:userapp/Screen/CommonWidgets/Lists/Hor_Card_List.dart';
import 'package:userapp/Screen/CommonWidgets/Lists/SponsorList.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/CommonWidgets/Popup.dart';
import 'package:userapp/Screen/NavigationScreens/Home/HomeMaster.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/Notification.dart';
import 'package:userapp/Services/Services/NearbyService.dart';

String latitude = "latitude";
String longitude = "longitude";

class Discovery extends StatefulHookWidget {
  Discovery({Key? key}) : super(key: key);

  @override
  _DiscoveryState createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery> {
  List<Discovery>? _usersDisplay = <Discovery>[];
  Placemark placemark = Placemark();
  bool Search = false;
  String City = "";
  late LocationData _locationData;
  double lat = 0;
  double long = 0;
  bool _isLoding = true;
  Position? currentLocation;
  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition();
  }

  // Location location = new Location();
  getlocations() async {
    setState(() {
      _isLoding = true;
    });
    lat = 0;
    long = 0;
    currentLocation = await locateUser();
    // _locationData = await location.getLocation();
    // location.onLocationChanged.listen((LocationData currentLocation) {
    lat = currentLocation!.latitude;
    long = currentLocation!.longitude;
    print("adskakdlasda" + lat.toString());
    context.read(nearbyProvider).getCategories(
          lat: lat,
          long: long,
        );
    // });
    setState(() {
      _isLoding = false;
    });
    List<Placemark> res =
        // await placemarkFromCoordinates(44.500000,	-89.500000);
        await placemarkFromCoordinates(
            currentLocation!.latitude, currentLocation!.longitude);
    setState(() {
      placemark = res[0];
    });
    setState(() {
      City = "${placemark.locality}";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getlocations();
    _latlong();
    super.initState();
  }

  _latlong() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(
      latitude,
      lat,
    );
    await prefs.setDouble(
      longitude,
      long,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _discoveryServiceInfoProvider = useProvider(nearbyProvider);
    return _isLoding
        ? LoadingWidget()
        : FutureBuilder<NearbyModel>(
            future: _discoveryServiceInfoProvider.getCategories(
                long: long, lat: lat),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;
                return Column(
                  children: [
                    AppbarWithIcon(
                      title: 'Discover Services',

                      // onTap: () {
                      //   setState(() {
                      //     Search = true;
                      //   });
                      // },
                      // onChanged: (searchText) {
                      //   searchText = searchText.toLowerCase();
                      //   setState(() {
                      //     searchText = searchText.toLowerCase();
                      //     _usersDisplay = _discoveryServiceInfoProvider
                      //         .nearbymodelEmpty.discovery!
                      //         .where((e) {
                      //           var fName = e.categoryName!.toLowerCase();
                      //           return fName.contains(searchText);
                      //         })
                      //         .cast<Discovery>()
                      //         .toList();
                      //   });
                      // },
                      icons: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => NotificationPopUp()));
                            },
                            child: SvgPicture.asset(
                              'assets/SVG/bellicon.svg',
                              width: 28,
                              height: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: data!.discovery!.isEmpty
                          ? Center(
                              child: Text("No Discovery"),
                            )
                          : ListView.separated(
                              itemCount:
                                  // Search
                                  //     ? _usersDisplay!.length
                                  //     :
                                  data.discovery!.length,
                              itemBuilder: (context, index) {
                                return Hor_Card_List(
                                  title:
                                      // Search
                                      //     ? _usersDisplay.toString()
                                      //     :
                                      '${data.discovery![index].categoryName}',
                                  marchantdetails:
                                      data.discovery![index].marchant,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 10,
                                );
                              },
                            ),
                    )
                  ],
                );
              }
              return Center(
                child: LoadingWidget(),
              );
            });
  }
}
