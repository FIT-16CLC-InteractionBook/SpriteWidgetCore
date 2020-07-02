import Foundation

public class PDFViewFactory: NSObject, FlutterPlatformViewFactory {
    let controller: FlutterViewController
     init(controller: FlutterViewController) {
         self.controller = controller
     }
     
     public func create(
         withFrame frame: CGRect,
         viewIdentifier viewId: Int64,
         arguments args: Any?
     ) -> FlutterPlatformView {
         let channel = FlutterMethodChannel(
             name: "webview" + String(viewId),
             binaryMessenger: controller as! FlutterBinaryMessenger
         )
         return PDFViewPlugin(frame, viewId: viewId, channel: channel, args: args)
     }
}
