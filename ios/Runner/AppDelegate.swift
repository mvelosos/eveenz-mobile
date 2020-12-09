import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Google Maps
    GMSServices.provideAPIKey("AIzaSyApNjv96BtchkBY9pJSdQAAlKpi17Hr_5o")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
