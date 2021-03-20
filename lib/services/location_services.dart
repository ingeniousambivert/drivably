  import 'package:geolocator/geolocator.dart';
  
  void getCurrentLocation() async{
    var locationMessage = "";
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    locationMessage = "$position.latitude , $position.longitude";
    print(locationMessage);
  }