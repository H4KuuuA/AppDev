//
//  PDFVIew.swift
//  Bookfy
//
//  Created by 大江悠都 on 2024/11/19.
//

import SwiftUI

struct PDFVIew: View {
    @State private var selectedPDF: URL?
    @State private var showDocumentPicker = false
    
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
                            //PDFViewer(fileURL: pdfURL)
                        }
                    }
                } header: {
                    Text("Select PDF from Files")
                        .textCase(.none)
                }
            }
        }
    }
}

#Preview {
    PDFVIew()
}
