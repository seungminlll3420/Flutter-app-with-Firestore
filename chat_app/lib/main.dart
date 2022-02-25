import 'package:chat_app/screens/chatting_page/chatting_controller.dart';
import 'package:chat_app/screens/chatting_page/chatting_page.dart';
import 'package:chat_app/screens/entrance_page/entrance_controller.dart';
import 'package:chat_app/screens/entrance_page/entrance_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      builder: (context, widget) {
        return MediaQuery(
          //Setting font does not change with system font size
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      },
      getPages: [
        GetPage(
          name: "/",
          page: () => EntrancePage(),
          binding: BindingsBuilder(() {
            Get.put(EntranceController());
          }),
        ),
        GetPage(
          name: "/chat/:name",
          page: () => ChattingPage(),
          binding: BindingsBuilder(() {
            var entranceController = Get.find<EntranceController>();

            Get.put(ChattingController(
              entranceController.uuid.value,
              entranceController.nickname.value,
              entranceController.chatingRoomName.value,
            ));
          }),
        ),
      ],
    );
  }
}
