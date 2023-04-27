import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Constant/InputStyle.dart';
import 'package:userapp/Screen/CommonWidgets/EditField.dart';
import 'package:userapp/Screen/NavigationScreens/Discovery/Discovery.dart';

class AppbarWithIcon extends StatefulHookWidget {
  String? title;
  Widget? icons;
  Widget? icosubIcons;
  ValueChanged<String>? onChanged;
  bool? backButton;
  GestureTapCallback? onTap;
  AppbarWithIcon({
    this.title = 'Title',
    this.onChanged,
    this.backButton,
    this.icons = const SizedBox(),
    this.icosubIcons = const SizedBox(),
    this.onTap,
  });

  @override
  State<AppbarWithIcon> createState() => _AppbarWithIconState();
}

class _AppbarWithIconState extends State<AppbarWithIcon> {
  double lat = 0;
  double long = 0;
  String City = "";
  Placemark placemark = Placemark();
  bool _isLoding = true;
  Position? currentLocation;
  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition();
  }

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
  void initState() {
    // TODO: implement initState
    getlocations();
    _latlong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _homeServiceInfoProvider = useProvider(homeServiceProvider);
    return Material(
      elevation: 0,
      child: Container(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.backButton == true
                      ? InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: primaryColor,
                            size: 25,
                          ),
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.title!.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style:
                                    TextStyle(fontFamily: 'bold', fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            widget.icons!
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: primaryColor,
                                    size: 14,
                                  ),
                                  Text(
                                    City.toString(),
                                    style: TextStyle(
                                        color: Color(0xff9d9d9d), fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            widget.icosubIcons!
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TextFormField(
                  onChanged: widget.onChanged,
                  onTap: widget.onTap,
                  decoration: transparentInputDecoration.copyWith(
                      isCollapsed: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(
                          Icons.search,
                          size: 20,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(8),
                      prefixIconConstraints: BoxConstraints(maxHeight: 30),
                      hintText:
                          'Search for ${_homeServiceInfoProvider.categoryName.toLowerCase()} ...',
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Color(0xff9d9d9d),
                          fontFamily: 'bold'),
                      filled: true,
                      fillColor: Color(0xfff2f2f3)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
