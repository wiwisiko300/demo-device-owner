package com.example.device_control

import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class DeviceControlPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var context: Context
    private lateinit var channel: MethodChannel
    private lateinit var devicePolicyManager: DevicePolicyManager
    private lateinit var adminComponent: ComponentName

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "device_control")
        channel.setMethodCallHandler(this)
        devicePolicyManager = context.getSystemService(Context.DEVICE_POLICY_SERVICE) as DevicePolicyManager
        adminComponent = ComponentName(context, AdminReceiver::class.java)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "hideApps" -> {
                hideApps()
                result.success(null)
            }
            "disableFactoryReset" -> {
                tryDisableFactoryReset()
                result.success(null)
            }
            "isDeviceOwner" -> {
                val isOwner = devicePolicyManager.isDeviceOwnerApp(context.packageName)
                result.success(isOwner)
            }
            else -> result.notImplemented()
        }
    }

    private fun hideApps() {
        val apps = listOf("com.google.android.youtube", "com.facebook.katana", "jp.naver.line.android")
        val pm = context.packageManager
        for (pkg in apps) {
            try {
                pm.setApplicationEnabledSetting(pkg, PackageManager.COMPONENT_ENABLED_STATE_DISABLED, PackageManager.DONT_KILL_APP)
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    private fun tryDisableFactoryReset() {
      if (!devicePolicyManager.isDeviceOwnerApp(context.packageName)) return
  
      // สำหรับ Android 6+ ปิด Factory Reset Protection (FRP)
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
          devicePolicyManager.setFactoryResetProtectionPolicy(adminComponent, null)
      }
  
      // สำหรับ Android 9+ เพิ่ม user restriction: no_factory_reset
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
          try {
              val method = devicePolicyManager.javaClass.getMethod(
                  "addUserRestriction", ComponentName::class.java, String::class.java
              )
              method.invoke(devicePolicyManager, adminComponent, "no_factory_reset")
          } catch (e: Exception) {
              e.printStackTrace()
          }
      }
    }
  

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
