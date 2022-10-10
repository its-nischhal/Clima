import 'package:geolocator/geolocator.dart';
class Locator{

  Position? position;

  Future<Position> fetchLocation() async{
    LocationPermission  permission= await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  }
}