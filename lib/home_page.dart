import 'dart:convert';
//import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:weather_app/Widgets/add_info.dart';
import 'package:weather_app/Widgets/weather_forecast.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  String cityName = "London";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      getCurrentWeather();
    });
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final res = await http.get(
        Uri.parse(
            'http://api.weatherapi.com/v1/forecast.json?key=5027cf11def14de9a57183913232108&q=$cityName'),
      );
      final data = jsonDecode(res.body);

      if (data == 'null') {
        throw 'An unexcepted error occur';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: getCurrentWeather, icon: const Icon(Icons.refresh)),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
         future: getCurrentWeather(),
         builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          //final List<dynamic> mainData = data['forecast']['forecastday']['hour'];

          final currentTemp = data['current']['temp_c'];
          final currentCon = data['current']['condition']['text'];
          final currentHum = data['current']['humidity'];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Enter City',
                    prefixIcon: Icon(Icons.location_city_rounded),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      if (value != '') {
                        cityName = value;
                      } else {
                        cityName = 'London';
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            '$currentTemp C',
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Icon(
                            currentCon == 'Cloud' || currentCon == 'Rain' || currentCon == 'Partly cloudy'
                                ? Icons.cloud
                                : Icons.sunny,
                            size: 60,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '$currentCon',
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Weather Forecast',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ForeCastwidget(
                          time: '09:00', icon: currentCon == 'Cloud' || currentCon == 'Rain' || currentCon == 'Partly cloudy'
                                ? Icons.cloud
                                : Icons.sunny, temp: data['forecast']['forecastday'][0]['hour'][9]['temp_c']),
                      ForeCastwidget(
                          time: '12:00', icon: currentCon == 'Cloud' || currentCon == 'Rain' || currentCon == 'Partly cloudy'
                                ? Icons.cloud
                                : Icons.sunny, temp: data['forecast']['forecastday'][0]['hour'][12]['temp_c']),
                      ForeCastwidget(
                          time: '15:00',
                          icon: currentCon == 'Cloud' || currentCon == 'Rain' || currentCon == 'Partly cloudy'
                                ? Icons.cloud
                                : Icons.sunny,
                          temp: data['forecast']['forecastday'][0]['hour'][9]['temp_c']),
                      ForeCastwidget(
                          time: '18:00', icon: currentCon == 'Cloud' || currentCon == 'Rain' || currentCon == 'Partly cloudy'
                                ? Icons.cloud
                                : Icons.sunny, temp: data['forecast']['forecastday'][0]['hour'][18]['temp_c']),
                      ForeCastwidget(
                          time: '21:00', icon: currentCon == 'Cloud' || currentCon == 'Rain' || currentCon == 'Partly cloudy'
                                ? Icons.cloud
                                : Icons.sunny, temp: data['forecast']['forecastday'][0]['hour'][21]['temp_c']),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfo(
                        icon: Icons.water_drop,
                        mid: 'Humidity',
                        value: currentHum.toString()),
                    AdditionalInfo(
                        icon: Icons.air,
                        mid: 'Wind Speed',
                        value: data['current']['wind_kph'].toString()),
                    AdditionalInfo(
                        icon: Icons.beach_access,
                        mid: 'Pressure',
                        value: data['current']['pressure_in'].toString()),
                  ],
                )
              ],
            ),
          );
        },
      ),
     ),   
    );
  }
}
