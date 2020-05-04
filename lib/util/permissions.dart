import 'package:location_permissions/location_permissions.dart';

class Permissions {
  static Future<bool> checkLocationPermission() async {
    final access = await LocationPermissions().checkPermissionStatus();
    switch (access) {
      case PermissionStatus.unknown:
        return false;
      case PermissionStatus.denied:
        final permission = await LocationPermissions().requestPermissions(
          permissionLevel: LocationPermissionLevel.locationAlways,
        );
        if (permission == PermissionStatus.granted) {
          return true;
        } else {
          return false;
          // show error
        }
        break;
      case PermissionStatus.restricted:
        final permission = await LocationPermissions().requestPermissions(
          permissionLevel: LocationPermissionLevel.locationAlways,
        );
        if (permission == PermissionStatus.granted) {
          return true; // startLocator();
        } else {
          return false;
          // show error
        }
        break;
      case PermissionStatus.granted:
        return true;
        break;
    }
  }
}
