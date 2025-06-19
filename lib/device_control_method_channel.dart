import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'device_control_platform_interface.dart';

/// An implementation of [DeviceControlPlatform] that uses method channels.
class MethodChannelDeviceControl extends DeviceControlPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('device_control');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
