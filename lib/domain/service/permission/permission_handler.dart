import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<bool> checkOrActivateApptracking() async {
    bool isActivate = false;
    var status = await Permission.appTrackingTransparency.status;
    //The permission is'nt granted or limited and the user has not denied it permanently
    if ((!status.isGranted && !status.isLimited) &&
        !status.isPermanentlyDenied) {
      // Either the permission was already granted before or the user just granted it.
      status = await Permission.appTrackingTransparency.request();
      if (status.isGranted || status.isLimited) {
        isActivate = true;
      }
    } else {
      isActivate = true;
    }
    return isActivate;
  }
}
