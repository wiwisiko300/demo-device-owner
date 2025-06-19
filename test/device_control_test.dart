import 'package:flutter_test/flutter_test.dart';
import 'package:device_control/device_control_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceControlPlatform
    with MockPlatformInterfaceMixin
    implements DeviceControlPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  // final DeviceControlPlatform initialPlatform = DeviceControlPlatform.instance;

  // test('$MethodChannelDeviceControl is the default instance', () {
  //   expect(initialPlatform, isInstanceOf<MethodChannelDeviceControl>());
  // });

  // test('getPlatformVersion', () async {
  //   DeviceControl deviceControlPlugin = DeviceControl();
  //   MockDeviceControlPlatform fakePlatform = MockDeviceControlPlatform();
  //   DeviceControlPlatform.instance = fakePlatform;

  //   expect(await deviceControlPlugin.getPlatformVersion(), '42');
  // });
}
