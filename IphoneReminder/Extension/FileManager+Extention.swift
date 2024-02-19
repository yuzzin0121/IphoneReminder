//
//  FileManager+Extention.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/20/24.
//

import UIKit

extension UIViewController {
    func loadImageToDocument(filename: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        // 이 경로에 실제로 파일이 존재하는 지 확인
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)    // 도큐먼트 파일 경로로도 이미지를 가져올 수 있다.
        } else {
            return nil
        }
    }
    
    func saveImageToDocument(image: UIImage, filename: String) {
    
        // 앱 도큐먼트 위치 가져오기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        // 이미지를 저장할 경로(파일명) 지정
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        // 이미지 압축
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        // 이미지 파일 저장
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
}
