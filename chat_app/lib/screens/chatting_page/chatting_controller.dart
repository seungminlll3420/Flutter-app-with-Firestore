import 'package:chat_app/models/chatting_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChattingController extends GetxController {
  ChattingController(this.pk, this.name, this.chatting_room);

  final String pk;
  final String name;
  final String chatting_room;

  bool first = true;

  RxList<ChattingModel> chatrtingList = <ChattingModel>[].obs;

  Stream<QuerySnapshot> getSnapshot() {
    final f = FirebaseFirestore.instance;
    return f
        .collection(chatting_room)
        // .limit(1)
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
    bool state = true;
    bool timeState = false;
    bool timeStamp = true;

    if (chatrtingList.isNotEmpty) {
      state = (chatrtingList.first.pk != pk);
      timeState = (DateFormat('HH:mm').format(
              DateTime.fromMillisecondsSinceEpoch(
                  chatrtingList.first.upTime)) ==
          DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(now)));
      if (state == true || timeState == false) {
        timeStamp = true;
      } else {
        timeStamp = false;
      }
    }
    print(timeStamp);
    //   var x = await f
    //     .collection(chatting_room)
    //     .limit(1)
    //     .orderBy('upTime', descending: true)
    //     .get();
    // var ss = x.docs[0].data() as Map<String, dynamic>;
    await f
        .collection(chatting_room)
        .doc(now.toString())
        .set(ChattingModel(pk, name, text, now, state, timeStamp).toJson());
  }

  void load() async {
    print('최초 한번 실행해야 하는데;;');
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
      if (first) {
        first = false;
        return;
      }
      event.docChanges.forEach((e) {
        addOne(ChattingModel.fromJson(e.doc.data() as Map<String, dynamic>));
      });
      // print(event.docs);
      // print(event.docs[0].data() as Map<String, dynamic>);
      // addOne(
      //     ChattingModel.fromJson(event.docs[0].data() as Map<String, dynamic>));
    });
    super.onInit();
  }
}
