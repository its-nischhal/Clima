
import 'package:clime/constants.dart';
import 'package:clime/main.dart';
import 'package:clime/screens/search_screen.dart';
import 'package:clime/services/network_helper.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  final weatherData;
  const WeatherScreen({super.key, required this.weatherData});
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late String city;
  late String cityName;
  late double temperature;
  late String condition;
  late int humidity;
  late int sunriseUTC;
  late int sunsetUTC;
  late  DateTime sunriseTime;
  late  DateTime sunsetTime;
  late String sunrise;
  late String sunset;
  late double windSpeed;

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    condition = widget.weatherData['weather'][0]['main'];
    temperature = widget.weatherData['main']['temp'];
    humidity = widget.weatherData['main']['humidity'];
    cityName = widget.weatherData['name'];
    windSpeed = widget.weatherData['wind']['speed']*3.6;
    sunriseUTC = widget.weatherData['sys']['sunrise']*1000;
    sunsetUTC = widget.weatherData['sys']['sunset']*1000;
     sunriseTime = DateTime.fromMillisecondsSinceEpoch(sunriseUTC);
     sunsetTime = DateTime.fromMillisecondsSinceEpoch(sunsetUTC);
     if(sunriseTime.minute<10){
       sunrise = '${sunriseTime.hour}:0${sunriseTime.minute} AM';
     }
     else{
       sunrise = '${sunriseTime.hour}:${sunriseTime.minute} AM';
     }
    if(sunsetTime.minute<10){
      sunset = '${sunsetTime.hour%12}:0${sunsetTime.minute} PM';
    }
    else{
      sunset = '${sunsetTime.hour%12}:${sunsetTime.minute} PM';
    }

  }
  void setCityWeather(String location) async{
    String apiKey='c7f89026e2e039f48d01eb6b69aa4607';
    String url = 'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric';
    DataFetcher dataFetcher = DataFetcher(url: url);
    var cityWeatherData = await dataFetcher.fetchWeatherData();
    condition = cityWeatherData['weather'][0]['main'];
    temperature = cityWeatherData['main']['temp'];
    humidity = cityWeatherData['main']['humidity'];
    cityName = cityWeatherData['name'];
    windSpeed = cityWeatherData['wind']['speed']*3.6;
    sunriseUTC = cityWeatherData['sys']['sunrise']*1000;
    sunsetUTC = cityWeatherData['sys']['sunset']*1000;
    sunriseTime = DateTime.fromMillisecondsSinceEpoch(sunriseUTC);
    sunsetTime = DateTime.fromMillisecondsSinceEpoch(sunsetUTC);
    if(sunriseTime.minute<10){
      sunrise = '${sunriseTime.hour}:0${sunriseTime.minute} AM';
    }
    else{
      sunrise = '${sunriseTime.hour}:${sunriseTime.minute} AM';
    }
    if(sunsetTime.minute<10){
      sunset = '${sunsetTime.hour%12}:0${sunsetTime.minute} PM';
    }
    else{
      sunset = '${sunsetTime.hour%12}:${sunsetTime.minute} PM';
    }

    setState(() {

    });
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/loading.jpeg'), fit: BoxFit.fill)),
        child:
            SafeArea(
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const LoadingScreen();
                      }));
                    },
                    child: const Icon(
                      Icons.refresh,
                      size: 50.0,
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: ()async{
                      city=await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const SearchScreen();
                      }));
                      if(city!=null){
                        setState(() {
                          cityName= city;
                          setCityWeather(city);
                        });
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
          ),
          Text(
              cityName.toUpperCase(),
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white38),
          ),
          const SizedBox(
              height: 25.0,
          ),
          Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: kBoxDecoration,
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                          child: Text(
                        '${temperature.toInt()}℃',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold),
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:   [
                             const Text(
                                'SUNRISE',
                                style:  TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white60
                                ),
                              ),
                              Text(
                                sunrise,
                                style: const TextStyle(
                                  fontSize: 20.0
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:  [
                              const Text(
                                'SUNSET',
                                style: TextStyle(
                                    fontSize: 15.0,
                                  color: Colors.white60
                                ),
                              ),
                              Text(
                                sunset,
                                style: const TextStyle(
                                    fontSize: 20.0
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],

              ),
                  ),
                )),
          Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: kBoxDecoration,
                    child: Center(
                        child: Text(
                      condition,
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 50.0),
                    )),
                  ),
                )),
          Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: kBoxDecoration,
                        child: Center(
                            child: Text(
                          'Humidity $humidity%',
                          style: const TextStyle(fontSize: 20.0),
                        )),
                      ),
                    )),
                    Expanded(
                      flex: 1,
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: kBoxDecoration,
                        child: Center(
                            child: Text('Wind ${windSpeed.toStringAsFixed(1)} km/h',
                                style: const TextStyle(fontSize: 20.0))),
                      ),
                    )),
                  ],
                ))
        ]),
            ),
      ),
    );
  }
}
