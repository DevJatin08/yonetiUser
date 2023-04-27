import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Screen/NavigationScreens/Home/Chat/SingleCahtWidget.dart';

import '../../../../Constant/Global.dart';
import '../../../CommonWidgets/LoadingWidget.dart';

class AllChatList extends StatefulHookWidget {
  const AllChatList({Key? key}) : super(key: key);

  @override
  State<AllChatList> createState() => _AllChatListState();
}

class _AllChatListState extends State<AllChatList> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final _chatNotifier = useProvider(chatServiceProvider);
    return loading
        ? LoadingWidget()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: _chatNotifier.chats.length > 0
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SingleCahtWidget(
                            index: index,
                          ),
                          Divider(
                            thickness: .7,
                            height: 25,
                          )
                        ],
                      );
                    },
                    itemCount: _chatNotifier.chats.length,
                  )
                : Center(
                    child: Text('No group found'),
                  ),
          );
  }
}
