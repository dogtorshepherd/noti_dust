import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noti_dust/pages/auth_page.dart';
import 'package:noti_dust/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Permission.locationWhenInUse.onDeniedCallback(() {
    exit(0);
  }).onGrantedCallback(() {
    runApp(const MyApp());
  }).onPermanentlyDeniedCallback(() {
    exit(0);
  }).onRestrictedCallback(() {
    exit(0);
  }).onLimitedCallback(() {
    exit(0);
  }).onProvisionalCallback(() {
    exit(0);
  }).request();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
