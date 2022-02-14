import 'package:chat_app/models/chatting_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class ChattingController extends GetxController {
  ChattingController(this.pk, this.name, this.chatting_room);

  final String pk;
  final String name;

  bool first = true;
  final String chatting_room;

  RxList<ChattingModel> chatrtingList = <ChattingModel>[].obs;

  Stream<QuerySnapshot> getSnapshot() {
    final f = FirebaseFirestore.instance;
    return f
        .collection(chatting_room)
        .limit(1)
        .orderBy('upTime', descending: true)
        .snapshots();
  }

  void addOne(ChattingModel model) {
    chatrtingList.insert(0, model);
  }

  Future send(String text) async {
    if (text.isEmpty) {
      return;
    }
    var now = DateTime.now().millisecondsSinceEpoch;
    final f = FirebaseFirestore.instance;
    await f
        .collection(chatting_room)
        .doc(now.toString())
        .set(ChattingModel(pk, name, text, now).toJson());
  }

  void load() async {
    var now = DateTime.now().millisecondsSinceEpoch;
    final f = FirebaseFirestore.instance;
    var result = await f
        .collection(chatting_room)
        // .where('upTime', isGreaterThan: now)
        .orderBy('upTime', descending: true)
        .get();
    var l = result.docs.map((e) => ChattingModel.fromJson(e.data())).toList();
    chatrtingList.addAll(l);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    load();
    getSnapshot().listen((event) {
      print('한번실행해야하는데');
      if (first) {
        first = false;
        return;
      }
      addOne(
          ChattingModel.fromJson(event.docs[0].data() as Map<String, dynamic>));
    });
    super.onInit();
  }
}
