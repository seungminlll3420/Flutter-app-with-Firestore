import 'package:chat_app/screens/chatting_page/chatting_controller.dart';
import 'package:chat_app/widget/chatting_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ChattingPage extends GetView<ChattingController> {
  ChattingPage({Key? key}) : super(key: key);
  var data = Get.parameters;
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    bool afterTimeStamp = true;
    var afterTime;
    var afterPk;
    var first = true;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF000000),
        title: const Text(
          '나의 채팅방',
          style: TextStyle(color: Color(0xFF000000)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                first = true;
                afterTime = null;
                afterPk = null;
                return ListView(
                  reverse: true,
                  children: controller.chatrtingList.value.map((element) {
                    if (afterTime != null && afterPk != null) {
                      first = false;
                      if (afterTime !=
                              DateFormat('hh:mm').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      element.upTime)) ||
                          afterPk != element.pk) {
                        afterTimeStamp = true;
                      } else {
                        afterTimeStamp = false;
                      }
                    }
                    if (first == true) {
                      afterTimeStamp = true;
                    }
                    print(first);
                    print(element.text);
                    afterTime = DateFormat('hh:mm').format(
                        DateTime.fromMillisecondsSinceEpoch(element.upTime));
                    afterPk = element.pk;

                    return ChattingItem(
                        chattingModel: element, timeStamp: afterTimeStamp);
                  }).toList(),
                );
              },
            ),
          ),
          const Divider(
            thickness: 1.5,
            height: 1.5,
            color: Color(0xff111111),
          ),
          Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4),
            margin:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: TextField(
                      controller: textEditingController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(fontSize: 27),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '텍스트 입력',
                        hintStyle: TextStyle(color: Color(0xFF111111)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.send(textEditingController.text);
                    textEditingController.text = '';
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Icon(
                      Icons.arrow_circle_up,
                      size: 33,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
