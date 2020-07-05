//
//  PDFView.swift
//  Runner
//
//  Created by Tran Minh Nhut on 6/30/20.
//

import Foundation
import UIKit
import SwiftUI

public class PDFViewPlugin: NSObject, FlutterPlatformView {
    let frame: CGRect
    let viewId: Int64
    let channel: FlutterMethodChannel
    
    init(_ frame: CGRect, viewId: Int64, channel: FlutterMethodChannel, args: Any?) {
        self.frame = frame
        self.viewId = viewId
        self.channel = channel

        super.init()
        
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch(call.method) {
                case "initializePDF":
                    PDFChildView.rootView.pdfViewPublish.pdfUrl = call.arguments as? String;
                break
                case "changePage":
                    let nextPage = PDFChildView.rootView.pdfViewPublish.pdfView?.document?.page(at: call.arguments as! Int);
                        PDFChildView.rootView.pdfViewPublish.pdfView?.go(to: nextPage!);
            default:
                result(call.method)
            }
        })
    }
    
    public func view() -> UIView {
        return PDFChildView.view;
    }
}
