import 'dart:async';
import 'dart:io';

import 'package:noti_dust/controller/global_controller.dart';
import 'package:noti_dust/model/air_quality/air_quality.dart';
import 'package:noti_dust/model/air_quality/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:noti_dust/pages/auth_page.dart';

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
  }).onGrantedCallback(() async {
    Permission.notification.request();
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

void onBGServiceEnabled() {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  service.onDataReceived.listen((event) {
    if (event!['action'] == 'stopService') {
      service.stopBackgroundService();
    }
  });

  Timer.periodic(const Duration(minutes: 1), (timer) async {
    globalController.getLocation();
    final AirQuality airQuality = await globalController.getAirQualityData();
    Components components = airQuality.list![0].components!;
    double pm25 = components.pm25!;
    // print("FlutterBackgroundService ${DateTime.now()}\npm25: $pm25");
    service.setNotificationInfo(
      title: 'ปริมาณ PM2.5 = $pm25 μg/m\u00B3',
      content: '',
    );
  });
}

String aqiText(int aqi) {
  switch (aqi) {
    case 1:
      return 'Good';
    case 2:
      return 'Fair';
    case 3:
      return 'Moderate';
    case 4:
      return 'Poor';
    case 5:
      return 'Very Poor';
    default:
      return 'AQI';
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
