import 'package:drivably_app/services/api/client.dart';

import 'package:drivably_app/utils/storage/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../../../utils/constants/consts.dart';
import 'package:dio/dio.dart';
import 'dart:async';

final LatLngBounds sydneyBounds = LatLngBounds(
  southwest: const LatLng(-34.022631, 150.620685),
  northeast: const LatLng(-33.571835, 151.325952),
);

class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Dio dio = new Dio();

  String name = " ", plateNumber = "xx00xx0000";

  Future getData() async {
    String _token, _email;
    await getToken().then((value) {
      _token = value;
    });

    await getEmail().then((value) {
      _email = value;
    });

    String replaceEmail = _email.replaceAll('@', '%40');
    Response response = await dio.get(
      "$baseUrl/user/car/?email=$replaceEmail",
      options: Options(
        headers: {
          'Authorization': 'Bearer $_token',
        },
      ),
    );

    print(response.data);

    _email = response.data['data'][0]['owner_email'];

    var response1 = await dio.get(
      "$baseUrl/user/$_email",
      options: Options(
        headers: {
          'Authorization': 'Bearer $_token',
        },
      ),
    );

    setState(() {
      name = response1.data['data']['name'];
      plateNumber = response.data['data'][0]['car_license'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(23.0225, 72.5713),
    zoom: 11.0,
  );
  MapboxMapController mapController;

  // ignore: unused_field
  CameraPosition _position = _kInitialPosition;
  // ignore: unused_field
  bool _isMoving = false;
  bool _compassEnabled = false;
  CameraTargetBounds _cameraTargetBounds = CameraTargetBounds.unbounded;
  MinMaxZoomPreference _minMaxZoomPreference = MinMaxZoomPreference.unbounded;
  bool _rotateGesturesEnabled = true;
  bool _scrollGesturesEnabled = true;
  bool _tiltGesturesEnabled = true;
  bool _zoomGesturesEnabled = true;
  bool _myLocationEnabled = true;
  // ignore: unused_field
  bool _telemetryEnabled = true;
  MyLocationTrackingMode _myLocationTrackingMode = MyLocationTrackingMode.None;
  // ignore: unused_field
  List<Object> _featureQueryFilter;
  // Fill _selectedFill;

  void _onMapChanged() {
    setState(() {
      _extractMapInfo();
    });
  }

  void _extractMapInfo() {
    _position = mapController.cameraPosition;
    _isMoving = mapController.isCameraMoving;
  }

  @override
  void dispose() {
    mapController.removeListener(_onMapChanged);
    super.dispose();
  }

  // Creating Custom MapBox Widget
  @override
  Widget build(BuildContext context) {
    final MapboxMap mapboxMap = MapboxMap(
      accessToken: ACCESS_TOKEN,
      onMapCreated: onMapCreated,
      initialCameraPosition: _kInitialPosition,
      trackCameraPosition: true,
      compassEnabled: _compassEnabled,
      cameraTargetBounds: _cameraTargetBounds,
      minMaxZoomPreference: _minMaxZoomPreference,
      styleString: "mapbox://styles/blackdevil98/cklagsos11wb717pnn1dsieyq",
      rotateGesturesEnabled: _rotateGesturesEnabled,
      scrollGesturesEnabled: _scrollGesturesEnabled,
      tiltGesturesEnabled: _tiltGesturesEnabled,
      zoomGesturesEnabled: _zoomGesturesEnabled,
      myLocationEnabled: _myLocationEnabled,
      myLocationTrackingMode: _myLocationTrackingMode,
      myLocationRenderMode: MyLocationRenderMode.GPS,

      // ignore: todo
      // TODO : Implement Realtime Location here
      // onUserLocationUpdated: (location) {
      //   print(
      //       "new location: ${location.position}, alt.: ${location.altitude}, bearing: ${location.bearing}, speed: ${location.speed}, horiz. accuracy: ${location.horizontalAccuracy}, vert. accuracy: ${location.verticalAccuracy}");
      // },
    );

    APIServices _services = APIServices();

    return Scaffold(
      appBar: AppBar(
        title: Text(plateNumber),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: CircleAvatar(
                      radius: 30,
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, ${name[0].toUpperCase()}${name.substring(1)}",
                          style: TextStyle(
                            fontSize: 19,
                            color: Color(0xff000B22),
                          ),
                        ),
                        Text(
                          "Welcome back to your account",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xffB0B3BA),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: mapboxMap,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void onMapCreated(MapboxMapController controller) {
    mapController = controller;
    mapController.addListener(_onMapChanged);
    _extractMapInfo();

    mapController.getTelemetryEnabled().then((isEnabled) => setState(() {
          _telemetryEnabled = isEnabled;
        }));
  }
}
