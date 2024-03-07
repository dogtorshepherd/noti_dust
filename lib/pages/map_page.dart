import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:noti_dust/api/fetch_air_quality.dart';
import 'package:noti_dust/model/air_quality/air_quality.dart';
import 'package:noti_dust/model/air_quality/components.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Map<String, dynamic>> locations = [
    {"name": "กระบี่", "lat": 8.084629, "lng": 98.906365},
    {"name": "กรุงเทพมหานคร", "lat": 13.764872, "lng": 100.538063},
    {"name": "กาญจนบุรี", "lat": 14.022921, "lng": 99.532081},
    {"name": "กาฬสินธุ์", "lat": 16.564921, "lng": 103.629373},
    {"name": "กำแพงเพชร", "lat": 16.12582, "lng": 99.330312},
    {"name": "ขอนแก่น", "lat": 16.432269, "lng": 102.82342},
    {"name": "จันทบุรี", "lat": 12.607455, "lng": 102.107737},
    {"name": "ฉะเชิงเทรา", "lat": 13.541432, "lng": 101.617327},
    {"name": "ชลบุรี", "lat": 13.201687, "lng": 101.246886},
    {"name": "ชัยนาท", "lat": 15.090928, "lng": 99.983888},
    {"name": "ชัยภูมิ", "lat": 16.007686, "lng": 101.91736},
    {"name": "ชุมพร", "lat": 10.502878, "lng": 99.176077},
    {"name": "เชียงราย", "lat": 19.910021, "lng": 99.84054},
    {"name": "เชียงใหม่", "lat": 18.781397, "lng": 98.97771},
    {"name": "ตรัง", "lat": 7.55669, "lng": 99.609855},
    {"name": "ตราด", "lat": 12.243799, "lng": 102.510738},
    {"name": "ตาก", "lat": 17.052669, "lng": 99.058252},
    {"name": "นครนายก", "lat": 14.121445, "lng": 101.071207},
    {"name": "นครปฐม", "lat": 13.821027, "lng": 100.041551},
    {"name": "นครพนม", "lat": 17.411208, "lng": 104.56591},
    {"name": "นครราชสีมา", "lat": 14.972644, "lng": 102.078942},
    {"name": "นครศรีธรรมราช", "lat": 6.175497, "lng": 101.777793},
    {"name": "นครสวรรค์", "lat": 15.699114, "lng": 100.111173},
    {"name": "นนทบุรี", "lat": 13.918409, "lng": 100.401602},
    {"name": "นราธิวาส", "lat": 6.175497, "lng": 101.777793},
    {"name": "น่าน", "lat": 18.774471, "lng": 100.773231},
    {"name": "บึงกาฬ", "lat": 18.242665, "lng": 103.636413},
    {"name": "บุรีรัมย์", "lat": 14.995018, "lng": 103.111529},
    {"name": "ปทุมธานี", "lat": 14.023754, "lng": 100.675496},
    {"name": "ประจวบคีรีขันธ์", "lat": 12.158382, "lng": 99.822403},
    {"name": "ปราจีนบุรี", "lat": 13.92308, "lng": 101.578039},
    {"name": "ปัตตานี", "lat": 6.719822, "lng": 101.418741},
    {"name": "พระนครศรีอยุธยา", "lat": 14.365339, "lng": 100.583736},
    {"name": "พะเยา", "lat": 19.172554, "lng": 99.899508},
    {"name": "พังงา", "lat": 8.602806, "lng": 98.39959},
    {"name": "พัทลุง", "lat": 6.175497, "lng": 101.777793},
    {"name": "พิจิตร", "lat": 16.192261, "lng": 100.352093},
    {"name": "พิษณุโลก", "lat": 16.825587, "lng": 100.429805},
    {"name": "เพชรบุรี", "lat": 12.669516, "lng": 99.949071},
    {"name": "เพชรบูรณ์", "lat": 16.421725, "lng": 101.159561},
    {"name": "แพร่", "lat": 18.247179, "lng": 100.180239},
    {"name": "ภูเก็ต", "lat": 7.880448, "lng": 98.39225},
    {"name": "มหาสารคาม", "lat": 16.180973, "lng": 103.301561},
    {"name": "มุกดาหาร", "lat": 16.478905, "lng": 104.57259},
    {"name": "แม่ฮ่องสอน", "lat": 19.304033, "lng": 97.976985},
    {"name": "ยโสธร", "lat": 16.045253, "lng": 104.375086},
    {"name": "ยะลา", "lat": 6.195801, "lng": 101.262118},
    {"name": "ร้อยเอ็ด", "lat": 15.90375, "lng": 103.732531},
    {"name": "ระนอง", "lat": 9.959575, "lng": 98.637221},
    {"name": "ระยอง", "lat": 12.824779, "lng": 101.355054},
    {"name": "ราชบุรี", "lat": 13.533966, "lng": 99.811056},
    {"name": "ลพบุรี", "lat": 15.048613, "lng": 100.89165},
    {"name": "ลำปาง", "lat": 18.283701, "lng": 99.511233},
    {"name": "ลำพูน", "lat": 18.118148, "lng": 98.911908},
    {"name": "ศรีสะเกษ", "lat": 14.739689, "lng": 104.472133},
    {"name": "สกลนคร", "lat": 17.159971, "lng": 104.139851},
    {"name": "สงขลา", "lat": 7.55669, "lng": 100.607487},
    {"name": "สตูล", "lat": 6.621668, "lng": 100.067853},
    {"name": "สมุทรปราการ", "lat": 13.595152, "lng": 100.607487},
    {"name": "สมุทรสงคราม", "lat": 13.376507, "lng": 99.949663},
    {"name": "สมุทรสาคร", "lat": 13.570584, "lng": 100.21271},
    {"name": "สระบุรี", "lat": 14.563486, "lng": 100.906054},
    {"name": "สระแก้ว", "lat": 13.776204, "lng": 102.242381},
    {"name": "สิงห์บุรี", "lat": 14.890225, "lng": 100.317163},
    {"name": "สุโขทัย", "lat": 17.200083, "lng": 99.721703},
    {"name": "สุพรรณบุรี", "lat": 14.466969, "lng": 100.032881},
    {"name": "สุราษฎร์ธานี", "lat": 9.134024, "lng": 99.333506},
    {"name": "สุรินทร์", "lat": 14.929456, "lng": 103.776308},
    {"name": "หนองคาย", "lat": 17.78825, "lng": 102.752015},
    {"name": "หนองบัวลำภู", "lat": 17.175169, "lng": 102.346695},
    {"name": "อ่างทอง", "lat": 14.608249, "lng": 100.359206},
    {"name": "อำนาจเจริญ", "lat": 15.924047, "lng": 104.749485},
    {"name": "อุดรธานี", "lat": 17.396195, "lng": 102.796439},
    {"name": "อุตรดิตถ์", "lat": 17.621692, "lng": 100.091319},
    {"name": "อุทัยธานี", "lat": 15.304757, "lng": 99.467761},
    {"name": "อุบลราชธานี", "lat": 15.244673, "lng": 104.847311},
    {"name": "เลย", "lat": 17.2636, "lng": 101.662793},
  ];
  Set<Marker> markers = {};
  late Position userLocation;
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
  }

  @override
  void initState() {
    super.initState();
    setMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(userLocation.latitude, userLocation.longitude),
                zoom: 6,
              ),
              markers: markers,
            );
          } else {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> setMarker() async {
    for (var location in locations) {
      double lat = location['lat'];
      double lng = location['lng'];

      AirQuality airQuality = await FetchAirQualityAPI().processData(lat, lng);
      int aqi = airQuality.list![0].main!.aqi!;
      Components components = airQuality.list![0].components!;
      double pm25 = components.pm25!;

      String markerTitle = '${location['name']} $pm25';
      markers
          .addLabelMarker(LabelMarker(
              label: markerTitle,
              markerId: MarkerId(markerTitle),
              position: LatLng(lat, lng),
              backgroundColor: pm25Color(pm25),
              textStyle: aqi == 2
                  ? const TextStyle(
                      fontSize: 27.0,
                      color: Colors.black,
                      letterSpacing: 1.0,
                      fontFamily: 'Roboto Bold')
                  : const TextStyle(
                      fontSize: 27.0,
                      color: Colors.white,
                      letterSpacing: 1.0,
                      fontFamily: 'Roboto Bold')))
          .then((value) => setState(() {}));
    }
    AirQuality airQuality = await FetchAirQualityAPI()
        .processData(userLocation.latitude, userLocation.longitude);
    int aqi = airQuality.list![0].main!.aqi!;
    Components components = airQuality.list![0].components!;
    double pm25 = components.pm25!;

    String markerTitle = '$pm25';
    markers
        .addLabelMarker(LabelMarker(
            label: markerTitle,
            markerId: MarkerId(markerTitle),
            position: LatLng(userLocation.latitude, userLocation.longitude),
            backgroundColor: pm25Color(pm25),
            textStyle: aqi == 2
                ? const TextStyle(
                    fontSize: 27.0,
                    color: Colors.black,
                    letterSpacing: 1.0,
                    fontFamily: 'Roboto Bold')
                : const TextStyle(
                    fontSize: 27.0,
                    color: Colors.white,
                    letterSpacing: 1.0,
                    fontFamily: 'Roboto Bold')))
        .then((value) => setState(() {}));
  }

  MaterialColor aqiColor(int aqi) {
    switch (aqi) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      case 5:
        return Colors.purple;
      default:
        return Colors.green;
    }
  }

  MaterialColor pm25Color(double pm25) {
    if (pm25 < 15.1) {
      return Colors.blue;
    } else if (pm25 < 25.1) {
      return Colors.green;
    } else if (pm25 < 37.6) {
      return Colors.yellow;
    } else if (pm25 < 75.1) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
