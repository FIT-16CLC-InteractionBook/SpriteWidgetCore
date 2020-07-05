//
//  PDFViewController.swift
//  Runner
//
//  Created by Tran Minh Nhut on 6/30/20.
//

import SwiftUI
import PDFKit

class PDFDataObject: ObservableObject {
    @Published var pdfView: PDFView? = nil;
    @Published var pdfUrl: String? = nil;
}

class FetchApi {
    func getPDF(url: String, completion: @escaping (PDFView) -> ()) {
        print(url);
        let documentUrl = URL(string: url);
        let pdfView = PDFView();
        if let pdfDocument = PDFDocument(url: documentUrl!) {
            pdfView.autoresizesSubviews = true
            pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            pdfView.pageShadowsEnabled = false
            pdfView.autoScales = true
            pdfView.displayMode = .singlePage
            pdfView.displayDirection = .horizontal
            pdfView.document = pdfDocument
            
            // pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
            // pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            // pdfView.displayDirection = .vertical

            // pdfView.autoScales = true
            // pdfView.displayMode = .singlePage
            // pdfView.displaysPageBreaks = true
            // pdfView.document = pdfDocument
            DispatchQueue.main.async {
                completion(pdfView)
            }
        }
    }
}


struct PDFKitRepresentedView: UIViewRepresentable {
    let pdfView: PDFView

    init(pdfView: PDFView) {
        self.pdfView = pdfView
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        return self.pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}

struct PDFKitView: View {
    var pdfView: PDFView
    var body: some View {
        PDFKitRepresentedView(pdfView: pdfView)
    }
}

struct PDFViewController: View {
    @State var pdfView: PDFView? = nil;
    
    @ObservedObject var pdfViewPublish: PDFDataObject = PDFDataObject();
    
    @ViewBuilder
    var body: some View {
        if self.pdfViewPublish.pdfUrl == nil {
            Text("wait for render pdf")
        } else
        if pdfView != nil {
            PDFKitView(pdfView: pdfView!)
        } else {
            Text("wait for render pdf").onAppear {
                FetchApi().getPDF(url:  self.pdfViewPublish.pdfUrl!) { (pdfViewContent) in
                    self.pdfView = pdfViewContent;
                    self.pdfViewPublish.pdfView = pdfViewContent;
                }
            }
        }
    }
}

var PDFChildView = UIHostingController(rootView: PDFViewController());
