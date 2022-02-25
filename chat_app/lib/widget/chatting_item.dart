import 'package:chat_app/models/chatting_models.dart';
import 'package:chat_app/screens/chatting_page/chatting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChattingItem extends StatelessWidget {
  const ChattingItem(
      {Key? key, required this.chattingModel, required this.timeStamp})
      : super(key: key);
  final ChattingModel chattingModel;
  final bool timeStamp;
  @override
  Widget build(BuildContext context) {
    ChattingController chatting_controller = Get.find<ChattingController>();
    bool isMe = chatting_controller.pk == chattingModel.pk;
    var time = DateTime.fromMillisecondsSinceEpoch(chattingModel.upTime);

    return Container(
      padding: chattingModel.state
          ? const EdgeInsets.only(left: 16, right: 16, top: 16)
          : const EdgeInsets.only(left: 16, right: 16, top: 3),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (isMe == false)
                    if (chattingModel.state)
                      CircleAvatar(backgroundColor: Color(0xff111111))
                    else
                      CircleAvatar(backgroundColor: Color(0xffFFFFFF)),
                  if (isMe == true)
                    if (timeStamp)
                      Text(
                        DateFormat('a').format(time).toString() == 'PM'
                            ? '오후 ' + DateFormat('h:mm').format(time).toString()
                            : '오전 ' +
                                DateFormat('h:mm').format(time).toString(),
                        style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xff808080),
                            letterSpacing: -0.1,
                            fontWeight: FontWeight.w400),
                      ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                      maxWidth: MediaQuery.of(context).size.width * 0.6,
                    ),
                    decoration: BoxDecoration(
                      color: isMe
                          ? const Color(0xFF65d638)
                          : const Color(0xFFebebeb),
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(10),
                        bottomRight: const Radius.circular(10),
                        topLeft: Radius.circular(
                            chattingModel.state ? (isMe ? 10 : 0) : 10),
                        topRight: Radius.circular(
                            chattingModel.state ? (isMe ? 0 : 10) : 10),
                      ),
                    ),
                    child: Text(
                      chattingModel.text,
                      maxLines: null,
                      overflow: TextOverflow.visible,
                      style: isMe
                          ? const TextStyle(color: Color(0xffffffff))
                          : const TextStyle(color: Color(0xff111111)),
                    ),
                  ),
                  if (isMe == false)
                    if (timeStamp)
                      Text(
                        DateFormat('a').format(time).toString() == 'PM'
                            ? '오후 ' + DateFormat('h:mm').format(time).toString()
                            : '오전 ' +
                                DateFormat('h:mm').format(time).toString(),
                        style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xff808080),
                            letterSpacing: -0.1,
                            fontWeight: FontWeight.w400),
                      ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
