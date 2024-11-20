//
//  Scandocument.swift
//  Bookfy
//
//  Created by 大江悠都 on 2024/11/20.
//

//
//  ScanDoucumentView.swift
//  OCR_demo
//
//  Created by 大江悠都 on 2024/11/14.
//

import SwiftUI
import Vision
import VisionKit

struct ScanDocumentView: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var recognised: String
    
    // UIkitのビューコントローラーとSwiftUIのデータやイベントのやり取り
    func makeCoordinator() -> Coordinator {
        Coordinator(recognisedText: $recognised, parent: self)
    }
    
    // スキャンするためのカメラビューの表示
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController{
        let documentViewController = VNDocumentCameraViewController()
        documentViewController.delegate = context .coordinator
        return documentViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        
    }
    
    // UIViewControllerRepresentableにおけるデリゲートとデータの管理
    // スキャンした画像の処理
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        
        var recognisedText: Binding<String>
        var parent: ScanDocumentView
        
        init(recognisedText: Binding<String>, parent: ScanDocumentView) {
            self.recognisedText = recognisedText
            self.parent = parent
            
        }
        
        // スキャン完了後の処理
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            
            let extractedImages = extractImages(from: scan)
            
            let processedText = recognisedText(from: extractedImages)
            
            // 抽出した画像からOCRを使ってテキストを認識
            recognisedText.wrappedValue = processedText
        }
        
        // 画像からテキストを抽出
        // ページごとの画像(cgImage)を取り出して、配列に格納
        fileprivate func extractImages(from scan: VNDocumentCameraScan) -> [CGImage] {
            var extractedImages = [CGImage]()
            
            for index in 0..<scan.pageCount {
                let extractedImage = scan.imageOfPage(at: index)
                
                guard let cgImage = extractedImage.cgImage else {
                    continue
                }
                
                extractedImages.append(cgImage)
            }
            
            return extractedImages
        }
        
        fileprivate func recognisedText(from images: [CGImage]) -> String {
            
            var entireReconisedText = ""
            
            // VNRecognizeTextRequest・・・画像に含まれるテキストを認識するためのリクエスト
            let recognisedTextRequest = VNRecognizeTextRequest { request, error in
                
                guard error == nil else {return}    // エラー発生時に処理を停止
                
                // VNRecognizedTextObservation・・・OCRの結果を保持するオブジェクト
                guard let observations = request.results as? [VNRecognizedTextObservation]
                else {return}
                
                let maximumRecognitionCandidates = 1  // 認識結果の上位一つの候補を使用
                
                for observation in observations {
                    
                    guard let candidate =
                            observation.topCandidates(maximumRecognitionCandidates).first else
                    {continue}
                    
                    entireReconisedText += "\(candidate.string)\n"
                    
                }
            }
            
            recognisedTextRequest.recognitionLevel = .accurate
            
            // OCRを実行
            for image in images {
                
                // CGImageを入力として受け取り、OCRリクエストを処理
                let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
                
                // OCRリクエストを実行する
                try? requestHandler.perform([recognisedTextRequest])
            }
            
            return entireReconisedText
        }
    }
}
