import 'package:chat_app/models/chatting_models.dart';
import 'package:chat_app/screens/chatting_page/chatting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChattingItem extends StatelessWidget {
  const ChattingItem({Key? key, required this.chattingModel}) : super(key: key);
  final ChattingModel chattingModel;
  @override
  Widget build(BuildContext context) {
    ChattingController chatting_controller = Get.find<ChattingController>();
    bool isMe = chatting_controller.pk == chattingModel.pk;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              chattingModel.state
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: Text(chattingModel.name),
                    )
                  : Container(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4),
                decoration: BoxDecoration(
                  color: isMe ? Color(0xFF111111) : Color(0xFF555555),
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(30),
                    bottomRight: const Radius.circular(30),
                    topLeft: Radius.circular(
                        chattingModel.state ? (isMe ? 30 : 0) : 30),
                    topRight: Radius.circular(
                        chattingModel.state ? (isMe ? 0 : 30) : 30),
                  ),
                ),
                child: Text(
                  chattingModel.text,
                  maxLines: null,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(color: Color(0xffffffff)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
