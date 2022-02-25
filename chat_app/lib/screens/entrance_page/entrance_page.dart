import 'package:chat_app/screens/entrance_page/entrance_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntrancePage extends GetView<EntranceController> {
  const EntrancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                onChanged: (text) {
                  controller.chatingRoomName.value = text;
                },
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '채팅방 이름',
                  hintStyle: TextStyle(
                    color: Color(0xFF112233),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                onChanged: (text) {
                  controller.nickname.value = text;
                },
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '닉네임 입력',
                  hintStyle: TextStyle(
                    color: Color(0xFF112233),
                  ),
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                await Get.toNamed('/chat/${controller.uuid.value}');
              },
              child: Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: const Color(0xFF111111),
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: const Text('보내기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
