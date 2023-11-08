import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  const Weather({ super.key });
  final apiKey = "";

  @override
  State<Weather> createState() => WeatherState();
}

class WeatherState extends State<Weather> {

  WeatherInfo? weather;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("날씨"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "현재 날씨",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),
            ),
            FutureBuilder(
              future: getWeather(),
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData && weather != null) {
                  DateTime date = weather!.date;
                  return Column(
                    children: [
                      Text(
                        "${date.year}년 "
                        "${date.month.toString().padLeft(2, '0')}월 "
                        "${date.day.toString().padLeft(2, '0')}일 "
                        "${(date.minute > 45 ? date.hour : date.hour - 1).toString().padLeft(2, '0')}시 "
                        "30분 기준"
                      ),
                      Text(
                        "온도: ${weather!.nowTemp.toString()}°C",
                        style: const TextStyle(fontSize: 20)
                      ),
                      Text(
                        "강수량: ${weather!.rainfall.toString()}mm",
                        style: const TextStyle(fontSize: 20),
                      ),
                      (weather!.description != "없음")
                        ? Text("현재는 ${weather!.description}이 내리고 있습니다")
                        : const SizedBox.shrink()
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        )
      )
    );
  }

  Future<bool> getWeather() async {
    DateTime date = DateTime.now();
    final uri = Uri.parse("https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst")
        .replace(
          queryParameters: {
            'ServiceKey': widget.apiKey,
            'numOfRows': '1000',
            'dataType': 'JSON',
            'base_date': '${date.year}${date.month.toString().padLeft(2, '0')}'
                         '${date.day.toString().padLeft(2, '0')}',
            'base_time': '${((date.minute > 45) ? date.hour : date.hour - 1)
                            .toString().padLeft(2, '0')}00',
            'nx': '91', 'ny': '77' // 창원시 의창구 봉림동
          }
        );
    final res = await http.get(uri);
    
    final js = json.decode(res.body);
    weather = WeatherInfo(date, js['response']['body']['items']['item']);
    return true;
  } 
}

// 기상청에서 가져온 데이터는 무조건 오름차순이 되있다는 가정하에, 데이터 처리를 진행함

// T1H: 기온 (도씨)
// RN1: 1시간 강수량 (mm)
// SKY: 하늘 상태 (코드값)
// UUU: 동서바람성분 (m/s)

class WeatherInfo {
  late DateTime date;
  late double nowTemp;
  late double rainfall;
  late String description;
  
  
  WeatherInfo(this.date, List list)  {
    description = getDescription(int.parse(list[0]['obsrValue'])); // PTY
    rainfall = double.parse(list[2]['obsrValue']); // RN1
    nowTemp = double.parse(list[3]['obsrValue']); // T1H
  }

  String getDescription(int code) {
    switch (code) {
      case 1:
        return "비";
      case 2:
        return "비/눈";
      case 3:
        return "눈";
      case 4:
        return "소나기";
      case 5:
        return "빗방울";
      case 6:
        return "빗방울눌날림";
      case 7:
        return "눈날림";
      default:
        return "없음";
    }
  }
}