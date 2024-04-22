import 'package:permission_handler/permission_handler.dart';

class AosPermission {
  static const List<Permission> values = <Permission>[
    Permission.photos,
    Permission.camera,
    Permission.microphone,
    Permission.storage,
 //   Permission.notification,
  ];
}