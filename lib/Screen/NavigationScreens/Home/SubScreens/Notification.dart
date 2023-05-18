import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Screen/NavigationScreens/Home/Chat/all_chat_list.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/Components/NotificationAlert.dart';
import 'package:userapp/Screen/NavigationScreens/Home/SubScreens/Components/NotificationMessage.dart';

class NotificationPopUp extends ConsumerStatefulWidget {
  NotificationPopUp({Key? key}) : super(key: key);

  @override
  _NotificationPopUpState createState() => _NotificationPopUpState();
}

class _NotificationPopUpState extends ConsumerState<NotificationPopUp> {
  List popString = ['Message', "Alerts"];

  int selectedTap = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
        final counter = ref.watch(notificationProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                }, icon: Icon(Icons.arrow_back_rounded)),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Divider(
                      color: Color(0xFFCECECE),
                      height: 0,
                      thickness: 2,
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        child: Container(
                          height: 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: popString.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedTap = index;
                                    });
                                  },
                                  child: Container(
                                    width: size.width * 0.9 / 2,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: selectedTap == index
                                                    ? primaryColor
                                                    : Colors.transparent,
                                                width: 2))),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            popString[index],
                                            style: TextStyle(
                                              color: selectedTap == index
                                                  ? primaryColor
                                                  : Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          if (popString[index] == "Alerts")
                                            CircleAvatar(
                                              backgroundColor: Colors.redAccent,
                                                radius: 10,
                                                child: Text(
                                                    counter.result.count
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10)))
                                        ],
                                      ),
                                    )),
                                  ),
                                );
                              }),
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child:
                        selectedTap == 0 ? AllChatList() : NotificationAlert()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
