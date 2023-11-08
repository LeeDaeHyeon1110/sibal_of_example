import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SchoolMeal extends StatefulWidget {
  const SchoolMeal({ super.key });
  final apiKey = "f0491ec9a1784e2cb92d2a4070f1392b";

  @override
  State<SchoolMeal> createState() => SchoolMealState();
}

class SchoolMealState extends State<SchoolMeal> {
  DateTime date = DateTime.now();
  var meal = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("날씨"),
      ),
      body: Center(
        child: FutureBuilder<bool>(
          future: getMeal(), 
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${date.year}년 ${date.month.toString().padLeft(2, '0')}월 ${date.day.toString().padLeft(2, '0')}일",
                    style: const TextStyle( fontSize: 30 ),
                  ),
                  const Divider(),
                  for (var data in meal) ...[
                    Text(
                      data["MMEAL_SC_NM"],
                      style: const TextStyle( fontSize: 30, fontWeight: FontWeight.bold ),
                    ),
                    Text(
                      removeTrash(data["DDISH_NM"]),
                      textAlign: TextAlign.center,
                      style: const TextStyle( fontSize: 20 ),
                    ),
                    const Divider()
                  ]
                ]
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      )
    );
  }

  Future<bool> getMeal() async {
    date = DateTime.now();

    final uri = Uri.parse('https://open.neis.go.kr/hub/mealServiceDietInfo')
        .replace(
          queryParameters: {
            'KEY': widget.apiKey,
            'Type': 'json',
            'ATPT_OFCDC_SC_CODE': 'S10',
            'SD_SCHUL_CODE': '9010277',
            'MLSV_YMD': '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}'
          }
        );

    final res = await http.get(uri);

    meal = json.decode(res.body)['mealServiceDietInfo'][1]['row'];
    return true;
  }

  String removeTrash(String target) {
    RegExp numberExp = RegExp(r"\n|\((\d+\.*)*\)+|\&nbsp\;");
    RegExp newline = RegExp(r"<br\s*[\/]?>");
    RegExp hangul = RegExp(r"^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]\)");
 
    target = target.replaceAll(numberExp, '');
    var splited = target.split(newline);
    return splited.map((e) => e.replaceAll(hangul, "")).join('\n');
  }
}