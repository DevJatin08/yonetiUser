// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:userapp/Constant/ConstantValues.dart';

// class ChatScreen extends StatefulWidget {
//   String? name;
//   String? avtar;
//   ChatScreen({required this.name, required this.avtar});
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   TextEditingController _sendmessageController = TextEditingController();
//   GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   String defaultavtar =
//       "https://unwomen.org.au/wp-content/uploads/2020/09/Avitar_Image_Placeholder-1.png";
//   String message = "";
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     var currunttime = DateTime.now();

//     return Scaffold(
//         body: Stack(
//       children: [
//         Image.network(
//           widget.avtar!.isNotEmpty ? widget.avtar.toString() : defaultavtar,
//           height: size.height * 0.3,
//           width: size.width,
//           fit: BoxFit.cover,
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             height: size.height * 0.8,
//             width: size.width * 1,
//             decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(35),
//                     topRight: Radius.circular(35))),
//             child: Container(
//               margin: EdgeInsets.only(left: 10, right: 10, top: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 10, left: 10),
//                     child: Text(
//                       "${widget.name}",
//                       style: TextStyle(
//                           fontSize: 18,
//                           letterSpacing: 1,
//                           fontFamily: 'bold',
//                           color: thirdColor),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Divider(
//                     color: Color(0xffd7d7d7),
//                     height: 0,
//                     thickness: 3,
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                         itemCount: Mes.length,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               Align(
//                                 alignment: (index.isOdd)
//                                     ? Alignment.centerLeft
//                                     : Alignment.centerRight,
//                                 child: (index.isOdd)
//                                     ? Container(
//                                         margin:
//                                             EdgeInsets.symmetric(vertical: 10),
//                                         child: Row(
//                                           children: [
//                                             // CircleAvatar(
//                                             //   radius: 13,
//                                             //   backgroundImage: NetworkImage(
//                                             //       "https://mlhmvq6amqed.i.optimole.com/HIId8M4.WANK~27a14/w:940/h:788/q:auto/https://hackspirit.com/wp-content/uploads/2021/06/Copy-of-Copy-of-Copy-of-Rustic-Female-Teen-Magazine-Cover-52.jpg"),
//                                             // ),
//                                             SizedBox(
//                                               width: 5,
//                                             ),
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Container(
//                                                   margin: EdgeInsets.symmetric(
//                                                       vertical: 3),
//                                                   width: MediaQuery.of(context)
//                                                           .size
//                                                           .width /
//                                                       1.5,
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 20,
//                                                       vertical: 8),
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.only(
//                                                               topRight: Radius
//                                                                   .circular(13),
//                                                               topLeft: Radius
//                                                                   .circular(13),
//                                                               bottomRight:
//                                                                   Radius
//                                                                       .circular(
//                                                                           13)),
//                                                       color: Color(0xff173143)),
//                                                   child: Text(
//                                                     "${Mes[index].mesg}",
//                                                     style: TextStyle(
//                                                         fontSize: 14,
//                                                         color: Colors.white),
//                                                   ),
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Text(
//                                                       "${day[currunttime.weekday]}, ${month[currunttime.month - 1]} ${currunttime.day} ${currunttime.hour}:${currunttime.minute} ${(currunttime.hour < 12) ? "AM" : "PM"}",
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .caption!
//                                                           .copyWith(
//                                                               color: Color(
//                                                                   0xff4b5c66)),
//                                                     ),
//                                                     Icon(
//                                                       Icons.done,
//                                                       size: 15,
//                                                       color: Color(0xff4b5c66),
//                                                     ),
//                                                   ],
//                                                 )
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                       )
//                                     : Container(
//                                         margin:
//                                             EdgeInsets.symmetric(vertical: 10),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.end,
//                                           children: [
//                                             Container(
//                                               margin: EdgeInsets.symmetric(
//                                                   vertical: 3),
//                                               width: MediaQuery.of(context)
//                                                       .size
//                                                       .width /
//                                                   1.5,
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 15, vertical: 8),
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.only(
//                                                     topRight:
//                                                         Radius.circular(13),
//                                                     bottomLeft:
//                                                         Radius.circular(13),
//                                                     topLeft:
//                                                         Radius.circular(13)),
//                                                 color: Color(0xff4b6057),
//                                               ),
//                                               child: Text(
//                                                 "${Mes[index].mesg}",
//                                                 style: TextStyle(
//                                                     fontSize: 14,
//                                                     color: Colors.white),
//                                               ),
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.end,
//                                               children: [
//                                                 Text(
//                                                   "${day[currunttime.weekday]}, ${month[currunttime.month - 1]} ${currunttime.day} ${currunttime.hour}:${currunttime.minute} ${(currunttime.hour < 12) ? "AM" : "PM"}",
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .caption!
//                                                       .copyWith(
//                                                           color: Color(
//                                                               0xff4b5c66)),
//                                                 ),
//                                                 Icon(
//                                                   Icons.done,
//                                                   size: 15,
//                                                   color: Color(0xff4b5c66),
//                                                 ),
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                               ),
//                             ],
//                           );
//                         }),
//                   ),
//                   Container(
//                       height: 40,
//                       margin: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Form(
//                         key: _formkey,
//                         child: TextFormField(
//                           textAlign: TextAlign.start,
//                           controller: _sendmessageController,
//                           validator: (val) {
//                             if (val!.isEmpty ||
//                                 val == "" ||
//                                 val == " " ||
//                                 val == "  ") {
//                               return "";
//                             }
//                           },
//                           onSaved: (val) {
//                             setState(() {
//                               message = val!;
//                             });
//                           },
//                           maxLines: 1,
//                           decoration: InputDecoration(
//                             hintText: "Type something here...",
//                             isCollapsed: true,
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 8, horizontal: 10),
//                             hintStyle: TextStyle(color: Color(0xff9d9d9d)),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(color: Colors.grey)),
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10)),
//                             suffixIcon: IconButton(
//                               onPressed: () {
//                                 if (_formkey.currentState!.validate()) {
//                                   _formkey.currentState!.save();
//                                   Mes.add(mes(mesg: message));
//                                 }
//                               },
//                               icon: Icon(
//                                 FontAwesomeIcons.paperPlane,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 30, left: 10),
//           decoration:
//               BoxDecoration(shape: BoxShape.circle, color: Color(0xffCCCCCC)),
//           child: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ),
//       ],
//     ));
//   }
// }

// class mes {
//   String mesg;
//   mes({required this.mesg});
// }

// List<mes> Mes = [
//   mes(mesg: "Is there anything I can help you with?"),
//   mes(mesg: "I need help with one of your listed service!"),
//   mes(mesg: "Sure! which one you have a question for?"),
// ];

// List month = [
//   "Jan",
//   "Feb",
//   "March",
//   "April",
//   "May",
//   "June",
//   "July",
//   "Aug",
//   "Sep",
//   "Oct",
//   "Nov",
//   "Dec",
// ];
// List day = [
//   "Sun",
//   "Mon",
//   "Tues",
//   "Wednes",
//   "Thurs",
//   "Fri",
//   "Satur",
// ];
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';

class ChatScreen extends StatefulHookWidget {
  final String name;
  final String? merchantImage;

  const ChatScreen({required this.name, required this.merchantImage});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Timer timer;

  String message = "";
  TextEditingController _messageController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    // context.read(chatServiceProvider).cleanData();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      context.read(chatServiceProvider).getChat();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _useProvider = useProvider(userInfoProvider);
    final _chatProvider = useProvider(chatServiceProvider);
    final _marchantProvider = context.read(marchantProvider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      children: [
        Image.network(
          _useProvider.userData.avatar ?? 'https://content.latest-hairstyles.com/wp-content/uploads/crew-cut-for-men-500x333.jpg',
          height: size.height * 0.3,
          width: size.width,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: size.height * 0.8,
            width: size.width * 1,
            decoration:
                BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35))),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      widget.name,
                      style: TextStyle(fontSize: 18, letterSpacing: 1, fontFamily: 'bold', color: thirdColor),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: Color(0xffd7d7d7),
                    height: 0,
                    thickness: 3,
                  ),
                  Expanded(
                      child: _chatProvider.chatList == null
                          ? LoadingWidget()
                          : ListView.builder(
                              itemCount: _chatProvider.chatList!.length,
                              reverse: true,
                              itemBuilder: (context, index) {
                                bool isRight = (_chatProvider.chatList![index].appType == "user");
                                return Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerRight,
                                        //  (_chatProvider
                                        //             .chatList[index].appType ==
                                        //         "marchant")
                                        //     ? Alignment.centerRight
                                        //     : Alignment.centerLeft,
                                        child: Align(
                                          alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
                                          child: Column(
                                            crossAxisAlignment: isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  !isRight
                                                      ? Padding(
                                                          padding: EdgeInsets.only(bottom: 3),
                                                          child: CircleAvatar(
                                                            radius: 11,
                                                            backgroundImage: NetworkImage(
                                                              widget.merchantImage != null
                                                                  ? "${widget.merchantImage}.jpg"
                                                                  : "https://i0.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1",
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                  SizedBox(width: 3),
                                                  Container(
                                                    constraints: BoxConstraints(maxWidth: size.width / 1.5, minWidth: 10),

                                                    margin: EdgeInsets.symmetric(vertical: 3),
                                                    // width: MediaQuery.of(context)
                                                    //         .size
                                                    //         .width /
                                                    //     1.5,
                                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                                    decoration: BoxDecoration(
                                                      borderRadius: isRight
                                                          ? BorderRadius.only(
                                                              topRight: Radius.circular(13),
                                                              bottomLeft: Radius.circular(13),
                                                              topLeft: Radius.circular(13))
                                                          : BorderRadius.only(
                                                              topRight: Radius.circular(13),
                                                              topLeft: Radius.circular(13),
                                                              bottomRight: Radius.circular(13)),
                                                      color: isRight ? primaryColor : Color(0xff173042),
                                                    ),
                                                    child: Text(
                                                      "${_chatProvider.chatList![index].chatText}",
                                                      style: TextStyle(fontSize: 14, color: Colors.white),
                                                    ),
                                                  ),
                                                  SizedBox(width: 3),
                                                  isRight
                                                      ? Padding(
                                                          padding: EdgeInsets.only(bottom: 3),
                                                          child: CircleAvatar(
                                                            radius: 11,
                                                            backgroundImage: NetworkImage(
                                                              _useProvider.userData.avatar ??
                                                                  'https://i0.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1',
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
                                                children: [
                                                  !isRight
                                                      ? Icon(
                                                          Icons.done,
                                                          size: 15,
                                                          color: Color(0xff4b5c66),
                                                        )
                                                      : SizedBox(),
                                                  Text(
                                                    _chatProvider.chatList![index].messageTime,
                                                    style: Theme.of(context).textTheme.caption!.copyWith(color: Color(0xff4b5c66)),
                                                  ),
                                                  isRight
                                                      ? Icon(
                                                          Icons.done,
                                                          size: 15,
                                                          color: Color(0xff4b5c66),
                                                        )
                                                      : SizedBox(),
                                                ],
                                              )
                                            ],
                                          ),
                                        )),
                                  ],
                                );
                              })),
                  Container(
                      height: 40,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Form(
                        key: _formkey,
                        child: TextFormField(
                          controller: _messageController,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: "Type something here...",
                            isCollapsed: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            hintStyle: TextStyle(color: Color(0xff9d9d9d)),
                            errorBorder: UnderlineInputBorder(),
                            disabledBorder: UnderlineInputBorder(),
                            enabledBorder: UnderlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            suffixIcon: InkWell(
                              onTap: () {
                                if (_messageController.text.trim().isNotEmpty) {
                                  _chatProvider.Chat(
                                    chat_text: _messageController.text.trim(),
                                    // customerId: context
                                    //     .read(marchantProvider)
                                    //     .marchantId);
                                  );
                                  _messageController.clear();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Enter a Message"),
                                      backgroundColor: Colors.redAccent,
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                }
                              },
                              child: Icon(
                                FontAwesomeIcons.paperPlane,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

List month = [
  "Jan",
  "Feb",
  "March",
  "April",
  "May",
  "June",
  "July",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];
List day = [
  "Sun",
  "Mon",
  "Tues",
  "Wednes",
  "Thurs",
  "Fri",
  "Satur",
];
