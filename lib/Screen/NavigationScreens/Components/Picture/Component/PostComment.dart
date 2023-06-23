import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Comment/GetCommentDetail.dart';
import 'package:userapp/Screen/CommonWidgets/LoadingWidget.dart';

class PostComment extends ConsumerStatefulWidget {
  String? CommentId;
  String? ImageID;
  String? merchantId;
  String? imageUrl;

  PostComment(
      {Key? key, this.CommentId, this.ImageID, this.merchantId, this.imageUrl})
      : super(key: key);

  @override
  _PostCommentState createState() => _PostCommentState();
}

class _PostCommentState extends ConsumerState<PostComment> {
  // List commentdata = [];
  GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController commentController = TextEditingController();
  int height = 600;
  bool boxsize = true;
  String comment = "";

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   useProvider(getcommentProvider).CommentData.comments = List.generate(10, (index) =>     );
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _userProvider = ref.watch(userInfoProvider);
    final _getcommentProvider = ref.watch(getcommentProvider);
    final _addcommentProvider = ref.watch(marchantProvider);
    return SingleChildScrollView(
      child: Container(
        width: size.width * .9,
        height: boxsize ? height.toDouble() : size.height * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[100],
        ),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: FutureBuilder<GetCommentData>(
              future: _getcommentProvider.getCommentData(
                  ImageID: widget.ImageID.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data!.comments.length} Comment",
                        style: TextStyle(
                            fontSize: 20, letterSpacing: 1, fontFamily: 'bold'),
                      ),
                      Text(
                        "Photos",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff9d9d9d),
                            fontFamily: 'bold'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(color: Colors.grey, height: 0),
                      Expanded(
                        child: data.comments.isEmpty
                            ? Center(
                                child: Text("No Comment"),
                              )
                            : ListView.builder(
                                itemCount: data.comments.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 10,
                                                backgroundImage: data
                                                        .comments[index]
                                                        .avatar
                                                        .isNotEmpty
                                                    ? NetworkImage(
                                                        "${data.comments[index].avatar}")
                                                    : NetworkImage(
                                                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png"),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                child: Text(
                                                  "${data.comments[index].userName}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xff173143),
                                                      fontFamily: 'bold'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${data.comments[index].commentsDate}",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xff9d9d9d),
                                                fontFamily: 'medium'),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 30),
                                        child: Text(
                                          "${data.comments[index].comments}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'medium',
                                              color: thirdColor),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                      // SizedBox(
                      //   height: size.height * 0.24,
                      // ),
                      Form(
                        key: _formkey,
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: size.width * 0.04,
                                backgroundImage: NetworkImage(_userProvider
                                            .userData.avatar !=
                                        null
                                    ? _userProvider.userData.avatar!
                                    : "https://media.istockphoto.com/photos/lyttelton-harbour-christchurch-new-zealand-picture-id913331746?k=20&m=913331746&s=612x612&w=0&h=D4wdEJRVIQGb2XWaHWsd_PZiPWHoHCEJWO0rXHHoyGg="),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.88,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      margin: EdgeInsets.only(left: 10),
                                      child: TextFormField(
                                        validator: (val) {
                                          if (val!.isEmpty || val == " ") {
                                            return "Enter Comment";
                                          }
                                        },
                                        onChanged: ((value) {
                                          setState(() {
                                            comment = value;
                                          });
                                        }),
                                        onSaved: (val) {
                                          setState(() {
                                            comment = val!;
                                          });
                                        },
                                        onTap: () {
                                          setState(() {
                                            boxsize = false;
                                          });
                                        },
                                        controller: commentController,
                                        decoration: InputDecoration(
                                            hintText: "Typing your comment...",
                                            hintStyle:
                                                TextStyle(color: Colors.grey)),
                                      )),
                                  IconButton(
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        // _formkey.currentState!.save();
                                        _addcommentProvider.addCommentData(
                                          image_id: widget.ImageID.toString(),
                                          comments: comment,
                                          merchantId: widget.merchantId,
                                          imageUrl: widget.imageUrl,
                                        );
                                      } else {
                                        print('object');
                                      }
                                      setState(() {
                                        boxsize = true;
                                      });
                                      commentController.clear();
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.paperPlane,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return LoadingWidget();
              },
            )),
      ),
    );
  }
}

// class PostComment extends HookWidget {
//   String? CommentId;
//   String? ImageID;
//   PostComment({Key? key, this.CommentId, this.ImageID}) : super(key: key);
//   TextEditingController commentController = TextEditingController();
//   int height = 600;
//   bool boxsize = true;
//
//   @override
//   Widget build(BuildContext context) {
//     String comment = "";
//     final size = MediaQuery.of(context).size;
//     final _getcommentProvider = useProvider(getcommentProvider);
//     final _addcommentProvider = useProvider(marchantProvider);
//
//     return
//     SingleChildScrollView(
//       child: Container(
//         width: size.width * .9,
//         height:boxsize? height.toDouble():size.height*0.3,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           color: Colors.grey[100],
//         ),
//         child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(12.0),
//             ),
//             child: FutureBuilder<GetCommentData>(
//               future: _getcommentProvider.getCommentData(
//                   ImageID: ImageID.toString()),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   final data = snapshot.data;
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "${data!.comments.length} Comment",
//                         style: TextStyle(
//                             fontSize: 20, letterSpacing: 1, fontFamily: 'bold'),
//                       ),
//                       Text(
//                         "Photos",
//                         style: TextStyle(
//                             fontSize: 12,
//                             color: Color(0xff9d9d9d),
//                             fontFamily: 'bold'),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Divider(color: Colors.grey, height: 0),
//                       Expanded(
//                         child: data.comments.isEmpty
//                             ? Center(
//                                 child: Text("No Comment"),
//                               )
//                             : ListView.builder(
//                                 itemCount: data.comments.length,
//                                 itemBuilder: (context, index) {
//                                   return Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               CircleAvatar(
//                                                 radius: 10,
//                                                 backgroundImage: data
//                                                         .comments[index]
//                                                         .avatar
//                                                         .isNotEmpty
//                                                     ? NetworkImage(
//                                                         "${data.comments[index].avatar}")
//                                                     : NetworkImage(
//                                                         "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png"),
//                                               ),
//                                               Container(
//                                                 margin: EdgeInsets.symmetric(
//                                                     horizontal: 10,
//                                                     vertical: 10),
//                                                 child: Text(
//                                                   "${data.comments[index].userName}",
//                                                   style: TextStyle(
//                                                       fontSize: 16,
//                                                       color: Color(0xff173143),
//                                                       fontFamily: 'bold'),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Text(
//                                             "${data.comments[index].commentsDate}",
//                                             style: TextStyle(
//                                                 fontSize: 10,
//                                                 color: Color(0xff9d9d9d),
//                                                 fontFamily: 'medium'),
//                                           ),
//                                         ],
//                                       ),
//                                       Container(
//                                         margin: EdgeInsets.only(left: 30),
//                                         child: Text(
//                                           "${data.comments[index].comments}",
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontFamily: 'medium',
//                                               color: thirdColor),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               ),
//                       ),
//                       // SizedBox(
//                       //   height: size.height * 0.24,
//                       // ),
//                       Container(
//                         margin: EdgeInsets.only(left: 5),
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                               radius: size.width * 0.04,
//                               backgroundImage: NetworkImage(
//                                   "https://media.istockphoto.com/photos/lyttelton-harbour-christchurch-new-zealand-picture-id913331746?k=20&m=913331746&s=612x612&w=0&h=D4wdEJRVIQGb2XWaHWsd_PZiPWHoHCEJWO0rXHHoyGg="),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                     width: MediaQuery.of(context).size.width /
//                                         1.88,
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 10),
//                                     margin: EdgeInsets.only(left: 10),
//                                     child: TextFormField(
//                                       onTap: () {
//
//                                       },
//                                       controller: commentController,
//                                       decoration: InputDecoration(
//                                           hintText: "Typing your comment...",
//                                           hintStyle:
//                                               TextStyle(color: Colors.grey)),
//                                     )),
//                                 IconButton(
//                                   onPressed: () {
//                                     _addcommentProvider.addCommentData(
//                                       image_id: ImageID.toString(),
//                                       comments: commentController.text,
//                                     );
//                                     commentController.clear();
//                                   },
//                                   icon: Icon(
//                                     FontAwesomeIcons.paperPlane,
//                                     color: Colors.grey,
//                                     size: 20,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 }
//                 return LoadingWidget();
//               },
//             )),
//       ),
//     );
//   }
// }
