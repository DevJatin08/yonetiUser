import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Screen/CommonWidgets/CustomButton.dart';
import 'package:userapp/Screen/NavigationScreens/Discovery/Discovery.dart';
import 'package:userapp/Screen/NavigationScreens/Home/Homepage.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool homeMaster = false;
  late LocationData _locationData;
  late double lat;
  late double long;
  Location location = new Location();

  @override
  void initState() {
    super.initState();
    if (sharedPreferences.containsKey(latitude) && sharedPreferences.containsKey(longitude)) {
      setState(() {
        homeMaster = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log("$homeMaster", name: "Location");
    final size = MediaQuery.of(context).size;
    Path toppath = Path();
    toppath.moveTo(-size.width * 0.1, size.height * 0.1);
    toppath.arcToPoint(Offset(size.width * 0.35, -size.height * 0.05),
        radius: Radius.circular(90), clockwise: false, rotation: 10);
    Path bottomPath = Path();
    bottomPath.moveTo(size.width, size.height * 0.80);
    bottomPath.arcToPoint(Offset(size.width, size.height * 0.65),
        radius: Radius.circular(-20), clockwise: true, rotation: 90);
    return homeMaster
        ? HomePage()
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/map.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Hi,nice to meet you!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          color: Color(0xff173143),
                          letterSpacing: 1,
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'bold'),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 250,
                    child: Text(
                      "Set your location to start exploring services around you",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff9d9d9d),
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'semiBold'),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    fontSize: 16,
                    //    height: 20.0,
                    family: 'bold',
                    text: 'User current location',
                    voidCallback: () async {
                      _locationData = await location.getLocation();
                      location.onLocationChanged.listen((LocationData currentLocation) async {
                        lat = currentLocation.latitude!;
                        long = currentLocation.longitude!;
                        if (lat != null && long != null) {
                          List<Placemark> placeMark = await placemarkFromCoordinates(lat, long);
                          final place = placeMark.first;

                          ///Update User Address
                          if (place != null) {
                            await apiCall.apiUpdateUserAddress(
                              place.country!,
                              place.locality!,
                              "${place.street}, ${place.thoroughfare}, ${place.subLocality}",
                              place.postalCode!,
                            );
                          }
                          log(jsonEncode(placeMark), name: "Current Location");
                          await sharedPreferences.setDouble(
                            latitude,
                            lat,
                          );

                          await sharedPreferences.setDouble(
                            longitude,
                            long,
                          );
                        }
                        print("adskakdlasda" + lat.toString());
                        ref.watch(nearbyProvider).getCategories(
                          lat: lat,
                          long: long,
                        );
                      });
                      setState(() {
                        homeMaster = true;
                      });
                    },
                  )
                ],
              ),
            ),
          );
  }
}
