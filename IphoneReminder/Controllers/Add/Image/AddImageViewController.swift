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
    let addGalleryImageButton = AddImageButton()
    let takeACamareaButton = AddImageButton()
    let searchImageButton = AddImageButton()
    var configuration = PHPickerConfiguration()
    var currentImage: UIImage?
    var completionHandler: ((UIImage?) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let image = currentImage {
            completionHandler?(image)
        }
    }
    
    @objc private func addGalleryImageButtonClicked() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.allowsEditing = true
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
    
    @objc private func takeACamareaButtonClicked() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .camera
        present(imagePickerVC, animated: true)
    }
    
    @objc private func searchImageButtonClicked() {
        let searchImageVC = SearchImageViewController()
        searchImageVC.completionHandler = { link in
            if let link = link {
                self.setImage(link: link)
            }
        }
        navigationController?.pushViewController(searchImageVC, animated: true)
    }
    
    // 선택된 링크로 이미지 설정
    private func setImage(link: String) {
        if let url = URL(string: link) {
            selectedImageView.kf.setImage(with: url, placeholder: ImageStyle.photoFill)
            currentImage = selectedImageView.image
        } else {
            selectedImageView.image = ImageStyle.photoFill
            currentImage = nil
        }
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "우선 순위"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func configureHierarchy() {
        view.addSubview(selectedImageView)
        view.addSubview(addGalleryImageButton)
        view.addSubview(takeACamareaButton)
        view.addSubview(searchImageButton)
    }
    
    func configureLayout() {
        selectedImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.size.equalTo(200)
        }
        addGalleryImageButton.snp.makeConstraints { make in
            make.top.equalTo(selectedImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(44)
        }
        takeACamareaButton.snp.makeConstraints { make in
            make.top.equalTo(addGalleryImageButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(44)
        }
        searchImageButton.snp.makeConstraints { make in
            make.top.equalTo(takeACamareaButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(44)
        }
    }
    func configureView() {
        view.backgroundColor = ColorStyle.darkBlack
        selectedImageView.image = ImageStyle.photoFill
        selectedImageView.tintColor = .systemGray6
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.layer.cornerRadius = 5
        selectedImageView.clipsToBounds = true
        
        addGalleryImageButton.setTitle("갤러리에서 선택", for: .normal)
        takeACamareaButton.setTitle("카메라 촬영", for: .normal)
        searchImageButton.setTitle("이미지 검색", for: .normal)
        
        addGalleryImageButton.addTarget(self, action: #selector(addGalleryImageButtonClicked), for: .touchUpInside)
        takeACamareaButton.addTarget(self, action: #selector(takeACamareaButtonClicked), for: .touchUpInside)
        searchImageButton.addTarget(self, action: #selector(searchImageButtonClicked), for: .touchUpInside)
    }
}

extension AddImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageView.image = pickedImage
            currentImage = selectedImageView.image
        }
        dismiss(animated: true)
    }
}
