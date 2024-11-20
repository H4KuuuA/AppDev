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
    @Binding var recognisedText: String // OCR結果をバインド変数として受け取る
    
    init(fileURL: URL, recognisedText: Binding<String>) {
        self.document = PDFDocument(url: fileURL)
        _recognisedText = recognisedText  // 初期化時にバインド変数を設定
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
        .onAppear {
            // PDFが表示されるときにOCRを実行
            if let document = self.document, let images = ScanDocumentView.extractImagesFromPDF(pdfDocument: document) {
                recognisedText = ScanDocumentView.performOCR(on: images)
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
            // プレビュー用にStateを作成して、recognisedTextをバインディングとして渡す
            PDFViewer(fileURL: Bundle.main.url(forResource: "example", withExtension: "pdf")!,
                      recognisedText: .constant(""))  // 空の文字列で初期化したバインディング
        } else {
            Text("PDFファイルが見つかりません")
        }
    }
}

