//
//  PDFVIew.swift
//  Bookfy
//
//  Created by 大江悠都 on 2024/11/19.
//

import SwiftUI

enum PDF {
    static let single = "Single PDF"
    static let multiple = "Multiple PDF"
}
struct PDFVIew: View {
    @State private var selectedPDF: URL?
    @State private var showDocumentPicker = false
    @State private var recognisedText: String = ""  // OCR結果を保存する状態変数
    
    var body: some View {
        NavigationStack {
            List{
                // PDF選択ボタン
                Section {
                    Button("PDFを選択") {
                        showDocumentPicker.toggle()
                    }
                    .sheet(isPresented: $showDocumentPicker) {
                        DocumentPicker(selectedURL: $selectedPDF)
                    }
                    
                    if let pdfURL = selectedPDF {
                        NavigationLink("選択したPDFを表示") {
                            PDFViewer(fileURL: pdfURL, recognisedText: $recognisedText)  // バインディングを渡す
                        }
                    }
                } header: {
                    Text("Select PDF from Files")
                        .textCase(.none)
                }
                // OCR結果表示セクション
                if !recognisedText.isEmpty {
                    Section(header: Text("OCR Result")) {
                        ScrollView {
                            Text(recognisedText)
                                .padding()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PDFVIew()
}
