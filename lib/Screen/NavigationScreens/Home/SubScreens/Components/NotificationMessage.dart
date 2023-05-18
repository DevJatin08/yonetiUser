// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Notification/NotificationDetail.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';

class NotificationMessage extends ConsumerStatefulWidget {
  NotificationMessage({Key? key}) : super(key: key);

  @override
  _NotificationMessageState createState() => _NotificationMessageState();
}

class _NotificationMessageState extends ConsumerState<NotificationMessage> {
  @override
  Widget build(BuildContext context) {
     final _notificationInfoProvider =  ref.watch(notificationProvider);

    return FutureBuilder<NotificationModal>(
        future: _notificationInfoProvider.getCategories(0),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            print("${data!.notification}");
            return data.notification!.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text("No Nofifications"),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('New Notifications', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 58 * 4,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.notification!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Container(
                                  height: 50,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Color(0xffe7eaf0),
                                        backgroundImage: NetworkImage(
                                          'https://images.unsplash.com/photo-1633114128174-2f8aa49759b0?ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1170&q=80',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: RichText(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                                text: "${data.notification![index].text}",
                                                // '${data.notification![index].text}',
                                                style: TextStyle(color: Colors.black),
                                                children: [
                                                  TextSpan(
                                                    text: ' ${data.notification![index].date} '.split(",").last.split(":").first,
                                                    style: TextStyle(color: Color(0xff8991a0)),
                                                  ),
                                                  TextSpan(
                                                    text: ' ${data.notification![index].notificationType} ',
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                  TextSpan(
                                                    text: '1h',
                                                    style: TextStyle(color: Color(0xff8991a0)),
                                                  )
                                                ])),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(color: Color(0xfff3f5f8), borderRadius: BorderRadius.circular(5)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Read', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 58 * 4,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Container(
                                  height: 50,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Color(0xffe7eaf0),
                                        backgroundImage: NetworkImage(
                                          'https://images.unsplash.com/photo-1633114128174-2f8aa49759b0?ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1170&q=80',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: RichText(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(text: 'Herbert Guzman', style: TextStyle(color: Colors.black), children: [
                                              TextSpan(
                                                text: 'left 5 star ',
                                                style: TextStyle(color: Color(0xff8991a0)),
                                              ),
                                              TextSpan(
                                                text: 'review',
                                                style: TextStyle(color: Colors.black),
                                              ),
                                              TextSpan(
                                                text: '1h',
                                                style: TextStyle(color: Color(0xff8991a0)),
                                              )
                                            ])),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(color: Color(0xfff3f5f8), borderRadius: BorderRadius.circular(5)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
          }
          return Center(child: LoadingWidget());
        });
  }
}
