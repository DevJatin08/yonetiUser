import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Screen/NavigationScreens/Home/Chat/Chat.dart';

import '../../../../Constant/ConstantValues.dart';
import '../../../../Constant/Global.dart';

class SingleCahtWidget extends HookConsumerWidget {
  final int index;

  const SingleCahtWidget({required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singleChat = ref.read(chatServiceProvider).chats[index];
    return InkWell(
      onTap: () {
        ref.read(chatServiceProvider).setCustomerId(singleChat.marchantId);
        ref.read(chatServiceProvider).setCurrentChat(singleChat);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              name: singleChat.fullName,
              merchantImage: singleChat.userImage,
            ),
          ),
        );
      },
      child: Container(
        // height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CircleAvatar(
              //   radius: 25,
              //   backgroundImage: NetworkImage(
              //       "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"),
              // ),
              Container(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100000),
                  child: Image.network(
                    "${singleChat.userImage}.jpg" ??
                        "https://i0.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    singleChat.fullName,
                    style: TextStyle(
                        fontSize: 18, color: primarySwatch[900], fontWeight: FontWeight.bold),
                  ),
                  Text(
                    singleChat.lastMsg,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: index.isEven ? Colors.grey : primarySwatch[600]),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  children: [
                    Text(
                      "${singleChat.lastDate}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: singleChat.unreadCount > 0 ? Colors.green : null,
                          fontSize: 12),
                    ),
                    if (singleChat.unreadCount > 0)
                      Container(
                        decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "${singleChat.cntUnread}",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
