import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Notification/NotificationDetail.dart';

class NotificationAlert extends ConsumerStatefulWidget {
  NotificationAlert({Key? key}) : super(key: key);

  @override
  _NotificationAlertState createState() => _NotificationAlertState();
}

class _NotificationAlertState extends ConsumerState<NotificationAlert> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _notificationInfoProvider = ref.watch(notificationProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New Notifications',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              child: FutureBuilder<NotificationModal>(
                future: _notificationInfoProvider.getCategories(0),
                builder: (context, snapshot) {
                  final notification = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && notification!.notification!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: notification.notification!.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final currentNotification = notification.notification![index];
                          return InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Container(
                                height: 50,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Color(0xffe7eaf0),
                                      backgroundImage: NetworkImage(
                                        currentNotification.senderAvatar!.isNotEmpty
                                            ? currentNotification.senderAvatar!
                                            : 'https://unwomen.org.au/wp-content/uploads/2020/09/Avitar_Image_Placeholder-1.png',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: size.width * 0.5,
                                      child: Text(
                                        currentNotification.text!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      currentNotification.date!,
                                      style: TextStyle(
                                        fontFamily: "regular",
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          "No New Notification",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "bold",
                          ),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Viewed Notifications',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              child: FutureBuilder<NotificationModal>(
                future: _notificationInfoProvider.getCategories(1),
                builder: (context, snapshot) {
                  final notification = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && notification!.notification!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: notification.notification!.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final readNotification = notification.notification![index];
                          return Container(
                            height: 50,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Color(0xffe7eaf0),
                                  backgroundImage: NetworkImage(
                                    readNotification.senderAvatar!.isNotEmpty
                                        ? readNotification.senderAvatar!
                                        : 'https://unwomen.org.au/wp-content/uploads/2020/09/Avitar_Image_Placeholder-1.png',
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: size.width * 0.5,
                                  child: Text(
                                    readNotification.text!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "regular",
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  readNotification.date!,
                                  style: TextStyle(
                                    fontFamily: "regular",
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          "No Viewed Notification",
                          style: TextStyle(
                            fontFamily: "bold",
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
