import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      var timerInitial = 0
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
          let channel = FlutterMethodChannel(name: "stop.watch.channel",
                                                    binaryMessenger: controller.binaryMessenger)
      channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          if(call.method == "startTimer"){
              timerInitial = timerInitial + 1
             result(timerInitial)
          }else if(call.method == "resetTimer"){
             timerInitial = 0
              result(timerInitial)
          }
          })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
