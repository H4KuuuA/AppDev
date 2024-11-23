//
//  PDFVIew.swift
//  Bookfy
//
//  Created by 大江悠都 on 2024/11/19.
//

import SwiftUI
import PDFKit

enum PDF {
    static let single = "Single PDF"
    static let multiple = "Multiple PDF"
}
// PDFのメタデータを管理する構造体
struct PDFMetadata {
    var title: String
    var author: String
}

struct PDFVIew: View {
    @State private var selectedPDF: URL?
    @State private var showDocumentPicker = false
    @State private var recognisedText: String = ""  // OCR結果を保存する状態変数
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var savedPDFs: [PDFMetadata] = []
    
    // 保存ボタンが押されたときの処理
        private func saveMetadata() {
            // PDFメタデータの作成
            let newMetadata = PDFMetadata(title: title, author: author)
            
            // 配列に追加（保存）
            savedPDFs.append(newMetadata)
            
            // 保存が完了したことを表示（アラートやログなど）
            print("PDF Metadata Saved: \(newMetadata)")
        }
    var body: some View {
        NavigationStack {
            List{
                // PDF選択ボタン
                Section("Select PDF from Files") {
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
                }
                // OCR結果表示セクション
//                if !recognisedText.isEmpty {
//                    Section(header: Text("OCR Result")) {
//                        ScrollView {
//                            Text(recognisedText)
//                                .padding()
//                        }
//                    }
//                }
            }
            .navigationTitle("ダウンロード")
        }
    }
}

#Preview {
    PDFVIew()
}
