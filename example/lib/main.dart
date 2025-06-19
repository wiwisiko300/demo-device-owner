import 'package:flutter/material.dart';
import 'package:device_control/device_control.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Control Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DeviceControlPage(),
    );
  }
}

class DeviceControlPage extends StatefulWidget {
  const DeviceControlPage({super.key});
  @override
  State<DeviceControlPage> createState() => _DeviceControlPageState();
}

class _DeviceControlPageState extends State<DeviceControlPage> {
  // bool _isDeviceOwner = false;
  String _statusMessage = "ยังไม่ตรวจสอบ";

  Future<void> _checkDeviceOwner() async {
    final result = await DeviceControl.isDeviceOwner();
    setState(() {
      // _isDeviceOwner = result;
      _statusMessage = result ? "✅ เป็น Device Owner" : "❌ ไม่ใช่ Device Owner";
    });
  }

  Future<void> _hideApps() async {
    try {
      await DeviceControl.hideApps();
      setState(() {
        _statusMessage = "ซ่อนแอพสำเร็จ";
      });
    } catch (e) {
      setState(() {
        _statusMessage = "ผิดพลาด: $e";
      });
    }
  }

  Future<void> _disableFactoryReset() async {
    try {
      await DeviceControl.disableFactoryReset();
      setState(() {
        _statusMessage = "ปิด factory reset สำเร็จ";
      });
    } catch (e) {
      setState(() {
        _statusMessage = "ผิดพลาด: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkDeviceOwner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device Control (Demo)')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "สถานะ Device Owner: $_statusMessage",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _checkDeviceOwner,
              icon: const Icon(Icons.security),
              label: const Text("ตรวจสอบ Device Owner"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _hideApps,
              icon: const Icon(Icons.visibility_off),
              label: const Text("ซ่อนแอพ: LINE / FB / YouTube"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _disableFactoryReset,
              icon: const Icon(Icons.lock),
              label: const Text("ปิด Factory Reset"),
            ),
          ],
        ),
      ),
    );
  }
}
