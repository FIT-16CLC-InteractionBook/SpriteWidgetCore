//
//  PDFViewController.swift
//  Runner
//
//  Created by Tran Minh Nhut on 6/30/20.
//

import SwiftUI
import PDFKit

class FetchApi {
    func getPDF(completion: @escaping (PDFView) -> ()) {
        let documentUrl = URL(string: "https://ncu.rcnpv.com.tw/Uploads/20131231103232738561744.pdf");
        let pdfView = PDFView();
        if let pdfDocument = PDFDocument(url: documentUrl!) {
            pdfView.autoresizesSubviews = true
            pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            pdfView.autoScales = true
            pdfView.displayMode = .singlePage
            pdfView.displaysPageBreaks = true
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
    
    @ViewBuilder
    var body: some View {
        if pdfView != nil {
            PDFKitView(pdfView: pdfView!)
        } else {
            Text("wait for render pdf").onAppear {
                FetchApi().getPDF { (pdfViewContent) in
                    self.pdfView = pdfViewContent
                }
            }
        }
    }
}

struct PDFViewController_Previews: PreviewProvider {
    static var previews: some View {
        PDFViewController()
    }
}

var PDFChildView = UIHostingController(rootView: PDFViewController())
