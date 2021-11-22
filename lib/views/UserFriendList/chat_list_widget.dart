
import 'package:flutter/material.dart';
import 'package:sauftrag/views/UserFriendList/chat_item_widget.dart';

class ChatListWidget extends StatelessWidget {

  final ScrollController listScrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) => ChatItemWidget(index),
          itemCount: 6,
          reverse: true,
          controller: listScrollController,
        ));
  }
}