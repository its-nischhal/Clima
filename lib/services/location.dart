import 'package:geolocator/geolocator.dart';
class Locator{

  late Position position;

  Future<Position> fetchLocation() async{
    // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }
    LocationPermission  permission= await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      Geolocator.requestPermission();
    }
    position =  await Geolocator.getCurrentPosition();
    return position;
  }
}