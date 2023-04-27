import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Album/Allalbum.dart';
import 'package:userapp/Model/ServiceAgainst/ServiceAgainst.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';
import 'package:userapp/Screen/CommonWidgets/Snackbar.dart';
import 'package:userapp/Screen/NavigationScreens/Components/Picture/AllPictureGrid.dart';
import 'package:userapp/Screen/NavigationScreens/Components/Picture/SinglePicture.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/Components/BackGroundScreen.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/Components/CommentScreen.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/Components/Schedule.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/Components/Template.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/SubScreens/CardDetail.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/SubScreens/PaymentHistory.dart';

class ReservationScreen extends StatefulHookWidget {
  String? name;
  String? ratting;

  ReservationScreen({Key? key, this.name, this.ratting}) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> with SingleTickerProviderStateMixin {
  bool expanded = false;
  bool isBarbarExpanded = false;
  DateTime now = DateTime.now();
  bool switchValue = false;
  List<int> typeNeg = [18, 19, 20];
  List<double> rating = [4.8, 4.9, 4.0];
  Map<String, dynamic>? paymentIntentData;

  // List timeList = ["10.30 am", "11.00 am", "11.30 am", '12.00 pm'];

  int dropdownValue = 18;
  double rationDropdownvalue = 4.8;
  int yourservice = 2;
  int selectCard = 0;
  MarchantServiceData? dropDownValue;
  Set<MarchantServiceData> SelectService = {};

  double sum = 0;
  int serviceTime = 0;
  String TotalSum = "";
  String totalTime = "";

  calculateSum() {
    sum = 0;
    serviceTime = 0;
    SelectService.forEach((element) {
      sum += double.parse(element.serviceCharged);
      TotalSum = (sum).toStringAsFixed(2);
      serviceTime += int.parse(element.estimatedTime);
      totalTime = time.toString();
      print(TotalSum);
    });
  }

  double Tax = 0;
  String TotalTax = "0";

  texsum() {
    Tax = 0;
    SelectService.forEach((element) {
      setState(() {
        Tax += (double.parse(element.serviceCharged) * 18 / 100);
        TotalTax = (Tax).toStringAsFixed(2);
        print(TotalTax);
      });
    });
  }

  DateTime selectDate = DateTime.now();
  String selectTime = "";
  DateTime time = getTime(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    final t = time.add(Duration(minutes: 30));
    selectTime = "${t.hour}:${t.minute}";
    LodingData();
  }

  bool isloding = true;

  Future LodingData() async {
    await context.read(marchantProvider).getServiceAgainst();
    isloding = false;
    setState(() {});
  }

  bool book = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _marchantProvider = useProvider(marchantProvider);
    return isloding == true
        ? Scaffold(
            body: Center(
              child: LoadingWidget(),
            ),
          )
        : Scaffold(
            body: SafeArea(
                child: book
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          BackGroundScreen(),
                          Container(
                            height: size.height * stackBodyHeight,
                            width: size.width,
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(hor_padding),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${widget.name}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xff173143),

                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: 'bold'),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(cardRadius), color: primaryColor),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                child: Text(
                                                  "${widget.ratting}",
                                                  style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'bold'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: bodyColor,
                                        thickness: dividerWidth,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: hor_padding),
                                        child: FutureBuilder<AllalbumData>(
                                            future: _marchantProvider.getCategories1(),
                                            builder: (context, snapshot) {
                                              if (dropDownValue == null) {
                                                dropDownValue = _marchantProvider.marchantService.MarchantServiceDatas.first;
                                              }
                                              if (snapshot.hasData) {
                                                final data = snapshot.data;
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Recent Uploads',
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(fontSize: 16, color: thirdColor, fontFamily: 'bold'),
                                                        ),
                                                        Expanded(
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (_) => AllPictureGrid(
                                                                            name: widget.name,
                                                                            reating: widget.ratting,
                                                                          )));
                                                            },
                                                            child: Text(
                                                              'See all (${data!.images.length})',
                                                              textAlign: TextAlign.end,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(fontSize: 16, color: primaryColor, fontFamily: 'bold'),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    data.images.isEmpty
                                                        ? Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Center(child: Text("No Data")),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          )
                                                        : Container(
                                                            height: 80,
                                                            child: ListView.builder(
                                                                itemCount: data.images.length,
                                                                scrollDirection: Axis.horizontal,
                                                                itemBuilder: (context, index) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets.only(right: 8.0),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (_) => SinglePicture(
                                                                                      name: widget.name,
                                                                                      image: data.images[index].name,
                                                                                      id: data.images[index].id,
                                                                                    )));
                                                                      },
                                                                      child: Container(
                                                                        height: 80,
                                                                        width: 80,
                                                                        decoration: BoxDecoration(
                                                                            color: thirdColor,
                                                                            borderRadius: BorderRadius.circular(cardRadius),
                                                                            image: DecorationImage(
                                                                                image: NetworkImage(data.images[index].name), fit: BoxFit.cover)),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'Select Service',
                                                      textAlign: TextAlign.end,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: thirdColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(color: reversationCardBorder),
                                                        borderRadius: BorderRadius.circular(cardRadius),
                                                      ),
                                                      child: DropdownButtonHideUnderline(
                                                        child: DropdownButton<MarchantServiceData>(
                                                          value: dropDownValue,
                                                          isExpanded: true,
                                                          items: _marchantProvider.marchantService.MarchantServiceDatas
                                                              .map(
                                                                (e) => DropdownMenuItem(
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            '${e.serviceTitle}',
                                                                            maxLines: 1,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                              fontSize: 13,
                                                                              color: cardSubTextColor,
                                                                              fontFamily: 'bold',
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            '${e.estimatedTime} minutes',
                                                                            maxLines: 1,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                              fontSize: 11,
                                                                              color: cardSubTextColor,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Color(0xfff9f9f9), borderRadius: BorderRadius.circular(5)),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                                                                          child: Text(
                                                                            '\$${e.serviceCharged}',
                                                                            maxLines: 1,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style:
                                                                                TextStyle(fontSize: 14, color: Color(0xffffb169), fontFamily: 'bold'),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  value: e,
                                                                  onTap: () {
                                                                    SelectService.add(e);
                                                                    snackbar('Your service was added', context);
                                                                    calculateSum();
                                                                    texsum();
                                                                  },
                                                                ),
                                                              )
                                                              .toList(),
                                                          onChanged: (service) {
                                                            setState(
                                                              () {
                                                                dropDownValue = service!;
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Hire Our Home Services',
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            color: thirdColor,
                                                          ),
                                                        ),
                                                        Switch(
                                                            value: switchValue,
                                                            onChanged: (v) {
                                                              setState(() {
                                                                switchValue = !switchValue;
                                                              });
                                                            })
                                                      ],
                                                    ),
                                                    if (switchValue)
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          // Container(
                                                          //   width: size.width,
                                                          //   decoration: BoxDecoration(
                                                          //       color: Colors.white,
                                                          //       border: Border.all(
                                                          //           color: reversationCardBorder),
                                                          //       borderRadius:
                                                          //           BorderRadius.circular(cardRadius)),
                                                          //   child: Column(
                                                          //     children: [
                                                          //       Row(
                                                          //         children: [
                                                          //           Container(
                                                          //             width: 5,
                                                          //             height: 60,
                                                          //             decoration: BoxDecoration(
                                                          //                 color: primaryColor,
                                                          //                 borderRadius:
                                                          //                     BorderRadius.only(
                                                          //                   topLeft: Radius.circular(
                                                          //                       cardRadius),
                                                          //                   bottomLeft: Radius.circular(
                                                          //                       cardRadius),
                                                          //                 )),
                                                          //           ),
                                                          //           Expanded(
                                                          //             child: Row(
                                                          //               mainAxisAlignment:
                                                          //                   MainAxisAlignment
                                                          //                       .spaceBetween,
                                                          //               children: [
                                                          //                 Expanded(
                                                          //                   flex: 2,
                                                          //                   child: Row(
                                                          //                     crossAxisAlignment:
                                                          //                         CrossAxisAlignment
                                                          //                             .center,
                                                          //                     children: [
                                                          //                       Expanded(
                                                          //                           child:
                                                          //                               barbarList()),
                                                          //                       SizedBox(
                                                          //                         width: 20,
                                                          //                       ),
                                                          //                       IconButton(
                                                          //                           icon: Icon(
                                                          //                             !serviceExpanded
                                                          //                                 ? Icons
                                                          //                                     .expand_more
                                                          //                                 : Icons
                                                          //                                     .expand_less,
                                                          //                           ),
                                                          //                           onPressed: () {
                                                          //                             setState(() {
                                                          //                               serviceExpanded =
                                                          //                                   !serviceExpanded;
                                                          //                             });
                                                          //                           }),
                                                          //                       SizedBox(
                                                          //                         width: 20,
                                                          //                       ),
                                                          //                     ],
                                                          //                   ),
                                                          //                 ),
                                                          //               ],
                                                          //             ),
                                                          //           ),
                                                          //         ],
                                                          //       ),
                                                          //       if (serviceExpanded)
                                                          //         Column(
                                                          //           children: [
                                                          //             barbarList(),
                                                          //             barbarList()
                                                          //           ],
                                                          //         )
                                                          //     ],
                                                          //   ),
                                                          // ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                border: Border.all(color: reversationCardBorder),
                                                                borderRadius: BorderRadius.circular(cardRadius)),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 5,
                                                                      height: 50,
                                                                      decoration: BoxDecoration(
                                                                          color: switchValue ? primaryColor : cardSubTextColor,
                                                                          borderRadius: BorderRadius.only(
                                                                            topLeft: Radius.circular(cardRadius),
                                                                            bottomLeft: Radius.circular(cardRadius),
                                                                          )),
                                                                    ),
                                                                    Expanded(
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            CircleAvatar(
                                                                              backgroundImage: NetworkImage(
                                                                                  'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F61688aa1d4a8658c3f4d8640%2FAntonio-Juliano%2F0x0.jpg%3Ffit%3Dscale'),
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            'Regular Haircut',
                                                                                            maxLines: 1,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            style: TextStyle(
                                                                                                fontSize: 13,
                                                                                                color: cardSubTextColor,
                                                                                                fontFamily: 'bold'),
                                                                                          ),
                                                                                          Text(
                                                                                            '45 minutes',
                                                                                            maxLines: 1,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            style: TextStyle(
                                                                                              fontSize: 11,
                                                                                              color: cardSubTextColor,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      decoration: BoxDecoration(
                                                                                          color: Color(0xfffee7cc),
                                                                                          borderRadius: BorderRadius.circular(5)),
                                                                                      child: Padding(
                                                                                        padding:
                                                                                            const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                                                                                        child: Text(
                                                                                          '\$18',
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: TextStyle(
                                                                                              fontSize: 14,
                                                                                              color: Color(0xffffb169),
                                                                                              fontFamily: 'bold'),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            IconButton(
                                                                                icon: Icon(
                                                                                  !isBarbarExpanded ? Icons.expand_more : Icons.expand_less,
                                                                                ),
                                                                                onPressed: () {
                                                                                  setState(() {
                                                                                    isBarbarExpanded = !isBarbarExpanded;
                                                                                  });
                                                                                }),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                if (isBarbarExpanded)
                                                                  Column(
                                                                    children: [
                                                                      barbarList(),
                                                                      barbarList(),
                                                                      barbarList(),
                                                                    ],
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 30,
                                                          ),
                                                        ],
                                                      ),
                                                    Text(
                                                      'Date & Time',
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: thirdColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    CalendarWidget(
                                                      date: (s) {
                                                        log("$s", name: "Date Of Order");
                                                        setState(() {
                                                          selectDate = s;
                                                        });
                                                      },
                                                      time: (d) {
                                                        log("$d", name: "Time Of Order");
                                                        setState(() {
                                                          selectTime = d;
                                                        });
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    if (SelectService.length > 0)
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Your Selected Services',
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              color: thirdColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                              height: (65 * SelectService.length).toDouble(),
                                                              child: ListView.builder(
                                                                  physics: NeverScrollableScrollPhysics(),
                                                                  itemCount: SelectService.length,
                                                                  itemBuilder: (context, index) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                                                      child: Container(
                                                                        width: size.width,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.white,
                                                                            border: Border.all(color: reversationCardBorder),
                                                                            borderRadius: BorderRadius.circular(cardRadius)),
                                                                        child: Row(
                                                                          children: [
                                                                            Container(
                                                                              width: 5,
                                                                              height: 50,
                                                                              decoration: BoxDecoration(
                                                                                  color: primaryColor,
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topLeft: Radius.circular(cardRadius),
                                                                                    bottomLeft: Radius.circular(cardRadius),
                                                                                  )),
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            '${SelectService.elementAt(index).serviceTitle}',
                                                                                            maxLines: 1,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            style: TextStyle(
                                                                                                fontSize: 13,
                                                                                                color: cardSubTextColor,
                                                                                                fontFamily: 'bold'),
                                                                                          ),
                                                                                          Text(
                                                                                            '${SelectService.elementAt(index).estimatedTime} minutes',
                                                                                            maxLines: 1,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            style: TextStyle(
                                                                                              fontSize: 11,
                                                                                              color: cardSubTextColor,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      decoration: BoxDecoration(
                                                                                          color: Color(0xfffee7cc),
                                                                                          borderRadius: BorderRadius.circular(5)),
                                                                                      child: Padding(
                                                                                        padding:
                                                                                            const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                                                                                        child: Text(
                                                                                          '\$${SelectService.elementAt(index).serviceCharged}',
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: TextStyle(
                                                                                              fontSize: 14,
                                                                                              color: Color(0xffffb169),
                                                                                              fontFamily: 'bold'),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 20,
                                                                                    ),
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        if (SelectService.length > 0) {
                                                                                          setState(() {
                                                                                            SelectService.remove(SelectService.elementAt(index));
                                                                                            // SelectService.contains(index)
                                                                                            //     ? sum
                                                                                            //     : sum -= int.parse(_marchantProvider.marchantService.MarchantServiceDatas[index].serviceCharged);
                                                                                            // : sum;
                                                                                            /*                            SelectService.remove(_marchantProvider
                                                                                  .marchantService
                                                                                  .MarchantServiceDatas[index]);*/
                                                                                            calculateSum();
                                                                                            texsum();
                                                                                          });
                                                                                        }
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.close,
                                                                                        color: Color(0xfff22626),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  })),
                                                        ],
                                                      ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                );
                                              }
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Recent Uploads',
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(fontSize: 16, color: thirdColor, fontFamily: 'bold'),
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.push(context, MaterialPageRoute(builder: (_) => AllPictureGrid()));
                                                          },
                                                          child: Text(
                                                            'See all (0)',
                                                            textAlign: TextAlign.end,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(fontSize: 16, color: primaryColor, fontFamily: 'bold'),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 80,
                                                    child: ListView.builder(
                                                        itemCount: 5,
                                                        scrollDirection: Axis.horizontal,
                                                        itemBuilder: (context, index) {
                                                          return Padding(
                                                            padding: const EdgeInsets.only(right: 8.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(context, MaterialPageRoute(builder: (_) => SinglePicture()));
                                                              },
                                                              child: Container(
                                                                height: 80,
                                                                width: 80,
                                                                decoration:
                                                                    BoxDecoration(color: thirdColor, borderRadius: BorderRadius.circular(cardRadius)),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Select Service',
                                                    textAlign: TextAlign.end,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: thirdColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(color: reversationCardBorder),
                                                      borderRadius: BorderRadius.circular(cardRadius),
                                                    ),
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton<MarchantServiceData>(
                                                        value: dropDownValue,
                                                        isExpanded: true,
                                                        items: _marchantProvider.marchantService.MarchantServiceDatas
                                                            .map(
                                                              (e) => DropdownMenuItem(
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          '${e.serviceTitle}',
                                                                          maxLines: 1,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                            fontSize: 13,
                                                                            color: cardSubTextColor,
                                                                            fontFamily: 'bold',
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${e.estimatedTime} minutes',
                                                                          maxLines: 1,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                            fontSize: 11,
                                                                            color: cardSubTextColor,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Color(0xfff9f9f9), borderRadius: BorderRadius.circular(5)),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                                                                        child: Text(
                                                                          '\$${e.serviceCharged}',
                                                                          maxLines: 1,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyle(fontSize: 14, color: Color(0xffffb169), fontFamily: 'bold'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                value: e,
                                                                onTap: () {
                                                                  SelectService.add(e);
                                                                  snackbar('Your service was added', context);
                                                                  calculateSum();
                                                                  texsum();
                                                                },
                                                              ),
                                                            )
                                                            .toList(),
                                                        onChanged: (service) {
                                                          setState(
                                                            () {
                                                              dropDownValue = service!;
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Hire Our Home Services',
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: thirdColor,
                                                        ),
                                                      ),
                                                      Switch(
                                                          value: switchValue,
                                                          onChanged: (v) {
                                                            setState(() {
                                                              switchValue = !switchValue;
                                                            });
                                                          })
                                                    ],
                                                  ),
                                                  if (switchValue)
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        // Container(
                                                        //   width: size.width,
                                                        //   decoration: BoxDecoration(
                                                        //       color: Colors.white,
                                                        //       border: Border.all(
                                                        //           color: reversationCardBorder),
                                                        //       borderRadius:
                                                        //           BorderRadius.circular(cardRadius)),
                                                        //   child: Column(
                                                        //     children: [
                                                        //       Row(
                                                        //         children: [
                                                        //           Container(
                                                        //             width: 5,
                                                        //             height: 60,
                                                        //             decoration: BoxDecoration(
                                                        //                 color: primaryColor,
                                                        //                 borderRadius:
                                                        //                     BorderRadius.only(
                                                        //                   topLeft: Radius.circular(
                                                        //                       cardRadius),
                                                        //                   bottomLeft: Radius.circular(
                                                        //                       cardRadius),
                                                        //                 )),
                                                        //           ),
                                                        //           Expanded(
                                                        //             child: Row(
                                                        //               mainAxisAlignment:
                                                        //                   MainAxisAlignment
                                                        //                       .spaceBetween,
                                                        //               children: [
                                                        //                 Expanded(
                                                        //                   flex: 2,
                                                        //                   child: Row(
                                                        //                     crossAxisAlignment:
                                                        //                         CrossAxisAlignment
                                                        //                             .center,
                                                        //                     children: [
                                                        //                       Expanded(
                                                        //                           child:
                                                        //                               barbarList()),
                                                        //                       SizedBox(
                                                        //                         width: 20,
                                                        //                       ),
                                                        //                       IconButton(
                                                        //                           icon: Icon(
                                                        //                             !serviceExpanded
                                                        //                                 ? Icons
                                                        //                                     .expand_more
                                                        //                                 : Icons
                                                        //                                     .expand_less,
                                                        //                           ),
                                                        //                           onPressed: () {
                                                        //                             setState(() {
                                                        //                               serviceExpanded =
                                                        //                                   !serviceExpanded;
                                                        //                             });
                                                        //                           }),
                                                        //                       SizedBox(
                                                        //                         width: 20,
                                                        //                       ),
                                                        //                     ],
                                                        //                   ),
                                                        //                 ),
                                                        //               ],
                                                        //             ),
                                                        //           ),
                                                        //         ],
                                                        //       ),
                                                        //       if (serviceExpanded)
                                                        //         Column(
                                                        //           children: [
                                                        //             barbarList(),
                                                        //             barbarList()
                                                        //           ],
                                                        //         )
                                                        //     ],
                                                        //   ),
                                                        // ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              border: Border.all(color: reversationCardBorder),
                                                              borderRadius: BorderRadius.circular(cardRadius)),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 5,
                                                                    height: 50,
                                                                    decoration: BoxDecoration(
                                                                        color: switchValue ? primaryColor : cardSubTextColor,
                                                                        borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(cardRadius),
                                                                          bottomLeft: Radius.circular(cardRadius),
                                                                        )),
                                                                  ),
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          CircleAvatar(
                                                                            backgroundImage: NetworkImage(
                                                                                'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F61688aa1d4a8658c3f4d8640%2FAntonio-Juliano%2F0x0.jpg%3Ffit%3Dscale'),
                                                                          ),
                                                                          Expanded(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Expanded(
                                                                                    flex: 2,
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Regular Haircut',
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: TextStyle(
                                                                                              fontSize: 13,
                                                                                              color: cardSubTextColor,
                                                                                              fontFamily: 'bold'),
                                                                                        ),
                                                                                        Text(
                                                                                          '45 minutes',
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: TextStyle(
                                                                                            fontSize: 11,
                                                                                            color: cardSubTextColor,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    decoration: BoxDecoration(
                                                                                        color: Color(0xfffee7cc),
                                                                                        borderRadius: BorderRadius.circular(5)),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                                                                                      child: Text(
                                                                                        '\$18',
                                                                                        maxLines: 1,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        style: TextStyle(
                                                                                            fontSize: 14,
                                                                                            color: Color(0xffffb169),
                                                                                            fontFamily: 'bold'),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          IconButton(
                                                                              icon: Icon(
                                                                                !isBarbarExpanded ? Icons.expand_more : Icons.expand_less,
                                                                              ),
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  isBarbarExpanded = !isBarbarExpanded;
                                                                                });
                                                                              }),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              if (isBarbarExpanded)
                                                                Column(
                                                                  children: [
                                                                    barbarList(),
                                                                    barbarList(),
                                                                    barbarList(),
                                                                  ],
                                                                )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                      ],
                                                    ),
                                                  Text(
                                                    'Date & Time',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: thirdColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  // CalendarWidget(),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  if (SelectService.length > 0)
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Your Selected Services',
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            color: thirdColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                            height: (65 * SelectService.length).toDouble(),
                                                            child: ListView.builder(
                                                                physics: NeverScrollableScrollPhysics(),
                                                                itemCount: SelectService.length,
                                                                itemBuilder: (context, index) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                                                    child: Container(
                                                                      width: size.width,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          border: Border.all(color: reversationCardBorder),
                                                                          borderRadius: BorderRadius.circular(cardRadius)),
                                                                      child: Row(
                                                                        children: [
                                                                          Container(
                                                                            width: 5,
                                                                            height: 50,
                                                                            decoration: BoxDecoration(
                                                                                color: primaryColor,
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(cardRadius),
                                                                                  bottomLeft: Radius.circular(cardRadius),
                                                                                )),
                                                                          ),
                                                                          Expanded(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Expanded(
                                                                                    flex: 2,
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          '${SelectService.elementAt(index).serviceTitle}',
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: TextStyle(
                                                                                              fontSize: 13,
                                                                                              color: cardSubTextColor,
                                                                                              fontFamily: 'bold'),
                                                                                        ),
                                                                                        Text(
                                                                                          '${SelectService.elementAt(index).estimatedTime} minutes',
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: TextStyle(
                                                                                            fontSize: 11,
                                                                                            color: cardSubTextColor,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    decoration: BoxDecoration(
                                                                                        color: Color(0xfffee7cc),
                                                                                        borderRadius: BorderRadius.circular(5)),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                                                                                      child: Text(
                                                                                        '\$${SelectService.elementAt(index).serviceCharged}',
                                                                                        maxLines: 1,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        style: TextStyle(
                                                                                            fontSize: 14,
                                                                                            color: Color(0xffffb169),
                                                                                            fontFamily: 'bold'),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 20,
                                                                                  ),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      if (SelectService.length > 0) {
                                                                                        setState(() {
                                                                                          SelectService.remove(SelectService.elementAt(index));
                                                                                          // SelectService.contains(index)
                                                                                          //     ? sum
                                                                                          //     : sum -= int.parse(_marchantProvider.marchantService.MarchantServiceDatas[index].serviceCharged);
                                                                                          // : sum;
                                                                                          /*                            SelectService.remove(_marchantProvider
                                                                                  .marchantService
                                                                                  .MarchantServiceDatas[index]);*/
                                                                                          calculateSum();
                                                                                          texsum();
                                                                                        });
                                                                                      }
                                                                                    },
                                                                                    child: Icon(
                                                                                      Icons.close,
                                                                                      color: Color(0xfff22626),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                })),
                                                      ],
                                                    ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              );
                                            }),
                                      ),
                                      Divider(
                                        color: Color(0xfff2f2f3),
                                        thickness: 1,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: hor_padding),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Payment',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: thirdColor,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            // InkWell(
                                            //     onTap: () {
                                            //       showModalBottomSheet(
                                            //           context: context,
                                            //           isScrollControlled: true,
                                            //           builder: (context) {
                                            //             return SelectCard(
                                            //               index: selectCard,
                                            //               cardIndex: (v) {
                                            //                 setState(() {
                                            //                   selectCard = v;
                                            //                 });
                                            //               },
                                            //             );
                                            //           });
                                            //       // showBottomSheet(
                                            //       //     context: context,
                                            //       //     builder: (context) {
                                            //       //       return SelectCard(
                                            //       //           // index: selectCard,
                                            //       //           // cardIndex: (v) {
                                            //       //           //   setState(() {
                                            //       //           //     // selectCard = v;
                                            //       //           //   });
                                            //       //           // }
                                            //       //           );
                                            //       //     });
                                            //     },
                                            //     child: PaymentCard()),
                                            // SizedBox(
                                            //   height: 10,
                                            // ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.forum,
                                                  color: Color(0xffb8b8b8),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                        isDismissible: true,
                                                        isScrollControlled: true,
                                                        context: context,
                                                        builder: (context) {
                                                          return CommentScreen();
                                                        });
                                                  },
                                                  child: Text(
                                                    'Leave a note or special instruction for merchant',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: 12, color: Color(0xffb8b8b8)),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
            bottomNavigationBar: SelectService.length == 0
                ? SizedBox()
                : Container(
                    width: size.width,
                    height: 82,
                    color: primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$$TotalSum',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'bold'),
                                ),
                                Text(
                                  'Tax \$$TotalTax',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  book = true;
                                });
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: primaryColor,
                                    context: context,
                                    builder: (context) {
                                      log("$selectDate", name: "Order Date");
                                      log("$selectTime", name: "Order Time");

                                      return Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: ProfileTemplate(
                                          widget: ProfileTemplate(
                                            widget: CardDetail(
                                              amount: double.parse(TotalSum) + double.parse(TotalTax),
                                              marchantId: _marchantProvider.marchantId,
                                              selectDate: selectDate,
                                              selectTime: selectTime,
                                              agentID: '',
                                              completionTime: totalTime,
                                              SelectService: SelectService,
                                            ),
                                            name: 'Payment',
                                            url: 'https://cdn.trendhunterstatic.com/thumbs/mastercard-logo.jpeg',
                                            extraImage: false,
                                          ),
                                          name: 'Payment',
                                          appBarButton: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return ProfileTemplate(
                                                      widget: PaymentHistory(),
                                                      name: 'Payment History',
                                                      extraImage: false,
                                                      appBarButton: IconButton(
                                                        icon: Icon(Icons.filter_alt),
                                                        onPressed: () {
                                                          showModalBottomSheet(
                                                              isScrollControlled: false,
                                                              context: context,
                                                              builder: (context) {
                                                                return Schedule();
                                                              });
                                                        },
                                                      ),
                                                      top: Colors.white,
                                                      bottom: Color(0xff454545),
                                                      // bottom: Colors.white,
                                                      // top: primaryColor,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(color: Color(0xff454545), borderRadius: BorderRadius.circular(3)),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                                child: Text(
                                                  'History',
                                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ),
                                          url: 'https://cdn.trendhunterstatic.com/thumbs/mastercard-logo.jpeg',
                                          extraImage: true,
                                        ),
                                      );
                                    });
                                // await _marchantProvider.bookingService(
                                // marchantId: _marchantProvider.marchantId,
                                // orderDate: selectDate,
                                // time: selectTime,
                                // agentID: '',
                                // serviceList: SelectService);

                                setState(() {
                                  book = false;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                  child: Text(
                                    'Book Now',
                                    style: TextStyle(fontSize: 16, color: thirdColor, fontFamily: 'bold'),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          );
  }

  Widget barbarList() {
    return InkWell(
      onTap: () {
        setState(() {
          yourservice = yourservice + 1;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F61688aa1d4a8658c3f4d8640%2FAntonio-Juliano%2F0x0.jpg%3Ffit%3Dscale'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Regular Haircut',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 13, color: cardSubTextColor, fontFamily: 'bold'),
                          ),
                          Text(
                            '45 minutes',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: cardSubTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Color(0xfffee7cc), borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                        child: Text(
                          '\$18',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, color: Color(0xffffb169), fontFamily: 'bold'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F61688aa1d4a8658c3f4d8640%2FAntonio-Juliano%2F0x0.jpg%3Ffit%3Dscale'),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Samuel Batadas',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: thirdColor,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Text(
                4.8.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'bold'),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget serviceTile(ServiceAgainstdata Servicedata, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          log(Servicedata.MarchantServiceDatas[index].toString());
          log(Servicedata.MarchantServiceDatas[index].serviceid.toString());
          SelectService.add(Servicedata.MarchantServiceDatas[index]);
          calculateSum();
          texsum();
          // sum = SelectService.contains(Servicedata.MarchantServiceDatas[index])
          //     ? sum += int.parse(
          //         Servicedata.MarchantServiceDatas[index].serviceCharged)
          // : sum;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(milliseconds: 400), content: Text("Added ${Servicedata.MarchantServiceDatas[index].serviceTitle} Service")));
          yourservice = yourservice + 1;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Container(
            //   width: 5,
            //   height: 50,
            //   decoration: BoxDecoration(
            //       color: cardSubTextColor,
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(cardRadius),
            //         bottomLeft: Radius.circular(cardRadius),
            //       )),
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${Servicedata.MarchantServiceDatas[index].serviceTitle}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 13, color: cardSubTextColor, fontFamily: 'bold'),
                          ),
                          Text(
                            '${Servicedata.MarchantServiceDatas[index].estimatedTime} minutes',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: cardSubTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Color(0xfffee7cc), borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                        child: Text(
                          '\$${Servicedata.MarchantServiceDatas[index].serviceCharged}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, color: Color(0xffffb169), fontFamily: 'bold'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  ValueChanged<DateTime> date;
  ValueChanged<String> time;

  CalendarWidget({
    required this.date,
    required this.time,
  });

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime now = DateTime.now();
  int selectedTimeIndex = 1;

  List<String> time = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String timePeroid = now.hour < 12 ? "am" : "pm";
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(cardRadius), border: Border.all(color: Color(0xffe5eced), width: 1)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TableCalendar(
              pageAnimationEnabled: false,
              pageJumpingEnabled: false,
              headerStyle: HeaderStyle(
                leftChevronVisible: false,
                formatButtonVisible: false,
              ),
              calendarFormat: CalendarFormat.week,
              onFormatChanged: (v) {},
              calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(color: Color(0xFF12425A), shape: BoxShape.circle),
                  outsideDecoration: BoxDecoration(color: Color(0xfff6f8f9), shape: BoxShape.circle),
                  defaultDecoration: BoxDecoration(color: Color(0xfff6f8f9), shape: BoxShape.circle),
                  weekendDecoration: BoxDecoration(color: Color(0xfff6f8f9), shape: BoxShape.circle),
                  selectedTextStyle: TextStyle(color: Colors.white),
                  defaultTextStyle: TextStyle(fontFamily: 'bold', fontSize: 15, color: Colors.black),
                  outsideTextStyle: TextStyle(fontFamily: 'bold', fontSize: 15, color: Colors.black),
                  weekendTextStyle: TextStyle(fontFamily: 'bold', fontSize: 15, color: Colors.black),
                  holidayTextStyle: TextStyle(fontFamily: 'bold', fontSize: 15, color: Colors.black),
                  todayTextStyle: TextStyle(fontFamily: 'bold', fontSize: 15, color: Colors.white),
                  todayDecoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle)),
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: now,
              currentDay: now,
              onDaySelected: (v, c) {
                DateTime cur = DateTime.now();
                setState(() {
                  if (cur.day == v.day) {
                    now = cur;
                  } else {
                    now = v;
                  }
                });
                widget.date(now);
              },
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cardRadius),
            border: Border.all(color: Color(0xffe5eced), width: 1),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Center(
              child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DateTime time = getTime(DateTime.now());

                    final t = time.add(Duration(minutes: index * 30));
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedTimeIndex = index;
                          widget.time("${t.hour}:${t.minute}");
                        });
                      },
                      child: Container(
                        width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(cardRadius), color: selectedTimeIndex == index ? primaryColor : Colors.transparent),
                        child: Center(
                            child: Text(
                          "${t.hour}:${t.minute}",
                          style: TextStyle(color: index == selectedTimeIndex ? Colors.white : Colors.black, fontSize: 12, fontFamily: 'bold'),
                        )),
                      ),
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}

DateTime getTime(DateTime t) {
  DateTime result = t;
  if (t.minute < 30) {
    result = DateTime(t.year, t.month, t.day, t.hour, 30);
    return result;
  }
  result = DateTime(t.year, t.month, t.day, t.hour, 60);
  return result;
}
