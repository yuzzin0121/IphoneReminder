//
//  FileManager+Extention.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/20/24.
//

import UIKit

extension UIViewController {
    // 도큐먼트/images에 있는 이미지 삭제하기
    func removeImageFromDocument(filename: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let imageDirectoryURL = documentDirectory.appendingPathComponent("images")
        let fileURL = imageDirectoryURL.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) { // 이미지 파일이 존재하는지 확인
            do {
                try FileManager.default.removeItem(atPath: fileURL.path())
            } catch {
                print("file remove error", error)
            }
        } else {
            print("file no exist, remove error")
        }
    }
    
    // 도큐먼트/images에서 이미지 가져오기
    func loadImageToDocument(filename: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let imageDirectoryURL = documentDirectory.appendingPathComponent("images") // 폴더 이름 설정
        
        let fileURL = imageDirectoryURL.appendingPathComponent("\(filename).jpg")
        
        // 이 경로에 실제로 파일이 존재하는 지 확인
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)    // 도큐먼트 파일 경로로도 이미지를 가져올 수 있다.
        } else {
            return nil
        }
    }
    
    // 이미지 도큐먼트/images에 저장하기
    func saveImageToDocument(image: UIImage, filename: String) {
    
        // 앱 도큐먼트 위치 가져오기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let imageDirectoryURL = documentDirectory.appendingPathComponent("images") // 폴더 이름 설정
        
        
        
        if !FileManager.default.fileExists(atPath: imageDirectoryURL.path()) {
            // 폴더 추가하기
            do {
                try FileManager.default.createDirectory(at: imageDirectoryURL, withIntermediateDirectories: false)
            } catch {
                print("create file error", error)
            }
        }
        
        // 이미지를 저장할 경로(파일명) 지정
        let fileURL = imageDirectoryURL.appendingPathComponent("\(filename).jpg")
        
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
