import 'package:start_journey/cleanArch/core/common/model/app_lat_long.dart';

abstract class AppLocation {
  Future<AppLatLong> getCurrentLocation();

  Future<bool> requestPermission();

  Future<bool> checkPermission();
}
