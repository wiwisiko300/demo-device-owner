import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'device_control_method_channel.dart';

abstract class DeviceControlPlatform extends PlatformInterface {
  /// Constructs a DeviceControlPlatform.
  DeviceControlPlatform() : super(token: _token);

  static final Object _token = Object();

  static DeviceControlPlatform _instance = MethodChannelDeviceControl();

  /// The default instance of [DeviceControlPlatform] to use.
  ///
  /// Defaults to [MethodChannelDeviceControl].
  static DeviceControlPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DeviceControlPlatform] when
  /// they register themselves.
  static set instance(DeviceControlPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
