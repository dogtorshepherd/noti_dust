import 'package:flutter/material.dart';
import 'package:noti_dust/model/air_quality/air_quality.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AQIDataWidget extends StatelessWidget {
  final AirQuality airQuality;

  const AQIDataWidget({Key? key, required this.airQuality}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int aqi = airQuality.list![0].main!.aqi!;
    double aqiPercent = (aqi) / 5;

    return Container(
      color: Colors.indigo[900],
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          padding: const EdgeInsets.only(top: 30, bottom: 5),
          color: Colors.white,
          alignment: Alignment.center,
          child: CircularPercentIndicator(
            radius: 120,
            lineWidth: 20,
            animation: true,
            animationDuration: 2000,
            startAngle: 185,
            percent: aqiPercent,
            progressColor: progressColor(aqi),
            backgroundColor: Colors.grey.shade200,
            circularStrokeCap: CircularStrokeCap.round,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 120, width: 120, child: aqiImage(aqi)),
                Text(
                  aqiText(aqi),
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 22),
                ),
              ],
            ),
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
        return Colors.amber;
      case 4:
        return Colors.deepOrange.shade400;
      case 5:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  Image aqiImage(int aqi) =>
      Image.asset('assets/images/$aqi.png'); //แสดงรูปฝุ่นในแบบต่างๆ 5 สถานะ

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
}
