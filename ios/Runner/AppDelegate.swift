import UIKit
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var flutterVC: FlutterViewController!

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller = window?.rootViewController as! FlutterViewController
    let pdfViewFactory = PDFViewFactory(controller: controller)
    registrar(forPlugin: "pdfview").register(pdfViewFactory, withId: "pdfview")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
