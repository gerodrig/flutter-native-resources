import UIKit
import Flutter
import GoogleMaps
import Foundation

//get API
func getAPIKey() -> String {
  if let url = Bundle.main.url(forResource: ".env", withExtension: nil) {
    do {
      let contents = try String(contentsOf: url)
      let lines = contents.split(separator: "\n")
      for line in lines {
        let parts = line.split(separator: "=")
        if parts.count == 2 && parts[0] == "GOOGLE_MAPS_API_KEY" {
          return String(parts[1])
        }
      }
    } catch {
      print("Error reading .env file")
    }
  }
  return ""
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey(getAPIKey())
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
