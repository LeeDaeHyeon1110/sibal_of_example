import 'package:sibal_of_example/information.dart';
import 'package:sibal_of_example/schoolmeal.dart';
import 'package:sibal_of_example/weather.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sibal of Coding',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sibal Of Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sibal Of Coding",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Flutter를 이용해 다양한 걸 만들어봅시다",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: 600,
                margin: const EdgeInsets.only(left: 50, right: 50, bottom: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AspectRatio(
                      aspectRatio: 2.2 / 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => const Weather())
                                );
                              }, 
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 0),
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                                )
                              ),
                              child: const Text(
                                "날씨",
                                style: TextStyle(
                                  fontSize: 30
                                ),
                              )
                            ),
                          ),
                          AspectRatio(
                            aspectRatio: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => const Information())
                                );
                              }, 
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 0),
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                                )
                              ),
                              child: const Text(
                                "정보",
                                style: TextStyle(
                                  fontSize: 30
                                ),
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 2.2 / 1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const SchoolMeal())
                          );
                        }, 
                        style: ElevatedButton.styleFrom(
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            )
                          ),
                        child: const Text(
                          "급식",
                          style: TextStyle(
                            fontSize: 30
                          ),
                        )
                      ),
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
