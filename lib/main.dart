import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/post_controller.dart';
import 'screens/home_screen.dart';

void main() {
  // Initialize the PostController
  Get.put(PostController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Media App',
      home: HomeScreen(),
    );
  }
}