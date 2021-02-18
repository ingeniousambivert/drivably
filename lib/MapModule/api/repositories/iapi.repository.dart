import 'package:drivably_app/MapModule/api/models/geocoding.model.dart';

abstract class IApiRepository {
  Future<GeocodingModel> performGeocoding(
    double latitude,
    double longitude,
  );
}
