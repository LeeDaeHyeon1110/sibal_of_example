import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  const Information({ super.key });

  @override
  State<Information> createState() => InformationState();
}

class InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("정보"),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            color: Colors.white,
            child: Image.asset(
              "assets/background.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.3 - 50
            ),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    "assets/logo.png"
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "코딩의 시발점",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const Text(
                  "다양한 코딩 활동을 하는 동아리입니다",
                ),
                const SizedBox(height: 40),
                const Text(
                  "구성",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "이제호(1214)\n맹강현(1408)\n김재민(1409)\n변준확(1411)\n변장언(2104)\n김예준(2802)",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    Text(
                      "김준우(2804)\n전성현(2810)\n표강준(2815)\n김상우(2801)\n박정훈(2204)\n이대현(2808)\n제한빈(2815)",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    )
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }
}