import 'package:clime/screens/weather_screen.dart';
import 'package:clime/services/location.dart';
import 'package:clime/services/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(
     MaterialApp(home: Scaffold(body:LoadingScreen()),theme: ThemeData.dark(),)
  );
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void fetchLocationData() async{
    Locator locator =  Locator();
    print('0');
    Position position =await locator.fetchLocation();
    String latitude = position.latitude.toString();
    String longitude = position.longitude.toString();
    print('reached 1');
    String apiKey='c7f89026e2e039f48d01eb6b69aa4607';
    String url = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    DataFetcher dataFetcher = DataFetcher(url: url);
    var weatherData =await dataFetcher.fetchWeatherData();
    print('reached 2');
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(weatherData: weatherData,);
    }));
  }
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    fetchLocationData();
  }
  Widget build(BuildContext context) {
    return    Scaffold(
        body:Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/loading.jpeg'),
              fit: BoxFit.fill
            )
        ),
        child:  Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:const [
              Text(
                  'FETCHING CURRENT WEATHER DATA. STAY CALM!!!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,

                ),
                textAlign: TextAlign.center,
              ),
               Center(
                child: SpinKitThreeBounce(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
