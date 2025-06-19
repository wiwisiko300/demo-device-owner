import 'package:flutter/services.dart';

class DeviceControl {
  static const MethodChannel _channel = MethodChannel('device_control');

  static Future<void> hideApps() async {
    await _channel.invokeMethod('hideApps');
  }

  static Future<void> disableFactoryReset() async {
    await _channel.invokeMethod('disableFactoryReset');
  }

  static Future<bool> isDeviceOwner() async {
    final result = await _channel.invokeMethod('isDeviceOwner');
    return result == true;
  }
}
