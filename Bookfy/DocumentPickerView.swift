//
//  DocumentPickerView.swift
//  Bookfy
//
//  Created by 大江悠都 on 2024/11/19.
//
import SwiftUI
import PDFKit

// PDFデータをローカルストレージに保存する関数
func savePDFToLcalStorage(pdfData: Data, fileName: String) -> URL? {
    let fileManager = FileManager.default
    guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
        return nil
    }
    // 保存先のファイルURLを作成
    let fileURL = documentsDirectory.appendingPathComponent(fileName)
    
    do {
        try pdfData.write(to: fileURL)
        print ("PDF saved at: \(fileURL.path)")
        return fileURL
    } catch {
        print("Error saving PDF: \(error)")
        return nil
    }
}
struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var selectedURL: URL?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        picker.delegate = context.coordinator
        picker.allowsMultipleSelection = false
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker
        
        init(_ parent: DocumentPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
                // ここでif letを使ってURLが取得できたか確認
                if let selectedURL = urls.first {
                    parent.selectedURL = selectedURL
                } else {
                    print("PDFが選択されませんでした。")
                }
            }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            // ユーザーがキャンセルした場合の処理
        }
    }
}


