import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class EntranceController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<TextEditingController> chattringEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> textEditingController = TextEditingController().obs;
  RxString uuid = Uuid().v1().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
