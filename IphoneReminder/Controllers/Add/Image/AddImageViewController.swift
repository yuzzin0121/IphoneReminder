//
//  AddImageViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit
import PhotosUI

class AddImageViewController: BaseViewController {
    let selectedImageView = UIImageView()
    var configuration = PHPickerConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "우선 순위"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addImage))
    }
    
    @objc func addImage() {
        configuration.filter = .any(of: [.images])
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    func configureHierarchy() {
        view.addSubview(selectedImageView)
    }
    func configureLayout() {
        selectedImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.centerY.equalToSuperview()
            make.size.equalTo(200)
        }
    }
    func configureView() {
        view.backgroundColor = ColorStyle.darkBlack
        selectedImageView.image = ImageStyle.photoFill
        selectedImageView.tintColor = .systemGray6
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.layer.cornerRadius = 5
        selectedImageView.clipsToBounds = true
    }
}

extension AddImageViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.selectedImageView.image  = image as? UIImage
                    self.selectedImageView.contentMode = .scaleAspectFill
                }
            }
        } else {
            print("이미지를 추가하는 과정에서 알 수 없는 오류가 났당...")
        }
    }
    
    
}
