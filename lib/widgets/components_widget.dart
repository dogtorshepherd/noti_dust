import 'package:noti_dust/model/air_quality/air_quality.dart';
import 'package:noti_dust/model/air_quality/components.dart';
import 'package:flutter/material.dart';


class ComponentsWidget extends StatelessWidget {
  final AirQuality airQuality;

  const ComponentsWidget({Key? key, required this.airQuality})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int aqi = airQuality.list![0].main!.aqi!;
    Components components = airQuality.list![0].components!;
    double no, co, no2, o3, so2, pm25, pm10, nh3;

    no = components.no!;
    co = components.co!;
    no2 = components.no2!;
    o3 = components.o3!;
    so2 = components.so2!;
    pm25 = components.pm25!;
    pm10 = components.pm10!;
    nh3 = components.nh3!;

    var labelArray = ['NO', 'CO', 'NO2', 'O3', 'SO2', 'PM2.5', 'PM10', 'NH3'];
    var valueArray = [no, co, no2, o3, so2, pm25, pm10, nh3];

    return Container(
      color: Colors.indigo[900],
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 56),
              Text(
                labelArray[5],
                style: const TextStyle(
                    color: Color.fromARGB(162, 0, 0, 0),
                    fontSize: 25,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 10),
              Container(
                child: Text(
                  '${valueArray[5]}',
                  style: TextStyle(
                      color: progressColor(aqi),
                      fontSize: 38,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                child: Text(
                  'µg/m\u00B3',
                  style: TextStyle(
                      color: Color.fromARGB(162, 0, 0, 0),
                      fontSize: 25,
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(height: 90),
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'source : OpenWeather',
                  style: const TextStyle(
                    color: Color.fromARGB(97, 0, 0, 0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Color progressColor(int aqi) {
    switch (aqi) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      case 3:
        return const Color.fromRGBO(218, 168, 7, 1);
      case 4:
        return const Color.fromARGB(255, 243, 67, 55);
      case 5:
        return const Color.fromARGB(255, 138, 10, 1);
      default:
        return Colors.blue;
    }
  }
}
