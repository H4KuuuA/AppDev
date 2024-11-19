//
//  PDFViewer.swift
//  Bookfy
//
//  Created by 大江悠都 on 2024/11/19.
//

import SwiftUI
import PDFKit

struct PDFViewer: View {
    @State private var currentPageIndex = 0
    private let document: PDFDocument?
    
    init(fileURL: URL) {
        self.document = PDFDocument(url: fileURL)
    }
    
    var body: some View {
        VStack {
            if let document = self.document {
                PDFKitView2(
                    document: document,
                    currentPageIndex: $currentPageIndex
                )
            } else {
                Text("エラーが発生しました。")
                    .font(.largeTitle.bold())
            }
        }
        .padding(.bottom, 100)
        .overlay(alignment: .bottom) {
            // ページ切り替えボタン
            if let document {
                HStack {
                    Button(action: {
                        currentPageIndex -= 1
                    }, label: {
                        Image(systemName: "arrowshape.backward.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                    })
                    .disabled(!(currentPageIndex > 0))
                    Spacer().frame(width: 30)
                    Button(action: {
                        currentPageIndex += 1
                    }, label: {
                        Image(systemName: "arrowshape.forward.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                    })
                    .disabled(!(currentPageIndex < document.pageCount-1))
                }
            }
        }
    }
}

struct PDFKitView2: UIViewRepresentable {
    let document: PDFDocument
    // PDFViewrとこのPDFKitView2の間でページインデックスが同期
    @Binding var currentPageIndex: Int
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = self.document
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        pdfView.backgroundColor = .clear
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        guard let document = uiView.document,
              currentPageIndex >= 0,
              currentPageIndex < document.pageCount,
              let page = document.page(at: currentPageIndex)
        else { fatalError() }
        uiView.go(to: page)
    }
}

struct PDFViewer_Previews: PreviewProvider {
    static var previews: some View {
        // pdfURLはプロジェクト内にあるPDFファイルのURLです。
        if let url = Bundle.main.url(forResource: "example", withExtension: "pdf") {
            PDFViewer(fileURL: url)
        } else {
            Text("PDFファイルが見つかりません")
        }
    }
}

