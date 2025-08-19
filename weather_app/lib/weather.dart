import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weather_app/key.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  void initState() {
    super.initState();
    getcurrentWeather();
  }

  String extractHourMinute(String datetime) {
    try {
      // Parse the string into a DateTime object
      DateTime dt = DateTime.parse(datetime);
      // Format and return only the hour and minute
      return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return "Invalid Date Format";
    }
  }

  void press_button_option() {
    print("Button Pressed");
  }

  Future<Map<String, dynamic>> getcurrentWeather() async {
    try {
      String countryName = "Nepal";
      final result = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$countryName&APPID=$weatherApikey",
        ),
      );
      final data = jsonDecode(result.body);
      if (data['cod'] != '200') {
        throw ("Error Occured (!200)!!");
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
    // final data = jsonDecode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final adName = ["Humidity", "Pressure", "Speed"];

    final List<IconData> symb = [
      Icons.water_drop,
      Icons.thermostat,
      Icons.speed,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(221, 37, 37, 47),
        title: Center(child: Text("Weather App")),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                getcurrentWeather();
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getcurrentWeather(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator.adaptive());
          }
          if (asyncSnapshot.hasError) {
            return Text(asyncSnapshot.error.toString());
          }
          final data = asyncSnapshot.data!;
          final dataList = data['list'][0];
          final currentTemp = dataList['main']['temp'];
          final currentIcon = dataList['weather'][0]['main'];
          double pressure = dataList['main']['pressure']?.toDouble() ?? 0.0;
          double humidity = dataList['main']['humidity']?.toDouble() ?? 0.0;
          double wind = dataList['wind']['speed']?.toDouble() ?? 0.0;
          final adValue = [humidity, pressure, wind];
          return Column(
            children: [
              SizedBox(
                child: Center(
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.3,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 70, 69, 69),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$currentTemp °K",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            currentIcon == "Rain"
                                ? Icons.cloudy_snowing
                                : currentIcon == "Clouds"
                                ? Icons.cloud
                                : Icons.sunny,
                          ),
                          Text(currentIcon),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.directional(
                  start: 0,
                  end: 0,
                  top: screenHeight * 0.03,
                  bottom: 0,
                ),
              ),
              SizedBox(
                child: Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.16,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(0, 37, 37, 47),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Weather Forecast",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.16,
                              child: ListView.builder(
                                itemCount: 7,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Mini_box(
                                      name: extractHourMinute(
                                        data['list'][index]["dt_txt"],
                                      ),
                                      statee:
                                          data["list"][index]['weather'][0]['main'],
                                      temp: data["list"][index]['main']['temp']
                                          .toString(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                          //  List.generate(
                          //   7,
                          //   (index) => Padding(
                          //     padding: EdgeInsets.only(left: 10),
                          //     child: Mini_box(
                          //       statee:data["list"][index]['weather'][0]['main'],
                          //       temp: data["list"][index]['main']['temp'].toString(),
                          //       name: extractHourMinute(data['list'][index]["dt_txt"]),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.directional(
                  start: 0,
                  end: 0,
                  top: screenHeight * 0.03,
                  bottom: 0,
                ),
              ),

              SizedBox(
                child: Center(
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.17,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 37, 37, 47),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Additional Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            symb.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Add_info(
                                value: adValue[index],
                                name: adName[index],
                                sym: symb[index],
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Add_info extends StatelessWidget {
  final IconData sym;
  final String name;
  final double value;
  const Add_info({
    super.key,
    required this.value,
    required this.name,
    required this.screenWidth,
    required this.screenHeight,
    required this.sym,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.25,
      height: screenHeight * 0.126,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(37, 37, 47, 0),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(sym, color: Colors.white, size: 32),
            Text(name),
            Text(value.toString()),
          ],
        ),
      ),
    );
  }
}

class Mini_box extends StatelessWidget {
  final String name;
  final String statee;
  final String temp;
  const Mini_box({
    super.key,
    required this.name,
    required this.statee,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return SizedBox(
      child: Container(
        width: screenWidth * 0.2,
        height: screenHeight * 0.11,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 20, 20, 31),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(blurRadius: 2)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
            Icon(
              statee == "Rain"
                  ? Icons.cloudy_snowing
                  : statee == "Clouds"
                  ? Icons.cloud
                  : Icons.sunny,
            ),
            Text(statee, style: TextStyle(fontSize: 12)),
            Text("$temp °K"),
          ],
        ),
      ),
    );
  }
}
