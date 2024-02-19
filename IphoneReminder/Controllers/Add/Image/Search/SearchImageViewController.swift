//
//  SearchImageViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/20/24.
//

import UIKit

class SearchImageViewController: BaseViewController {
    let mainView = SearchImageView()
    var imageList: [NaverImage] = []
    var completionHandler: ((String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureView()
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func selectImageAndPopView(link: String?) {
        completionHandler?(link)
        navigationController?.popViewController(animated: true)
    }
    
    private func configureView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.searchBar.delegate = self
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "이미지 검색"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func callRequest(query: String) {
        NaverAPIManager.shared.fetchData(type: NaverImageModel.self, api: .image(query: query)) { [self] NaverImageModel, error in
            if error == nil {
                guard let naverImageModel = NaverImageModel else { return }
                self.imageList = naverImageModel.items
                mainView.collectionView.reloadData()
            } else {
                guard let error = error else { return }
                switch error {
                case .failedRequest:
                    print("failedRequest")
                case .noData:
                    print("noData")
                case .invalidResponse:
                    print("invalidResponse")
                case .invalidData:
                    print("invalidData")
                }
            }
        }
    }
}

extension SearchImageViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        callRequest(query: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        imageList = []
        mainView.collectionView.reloadData()
    }
}

extension SearchImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NaverImageCollectionViewCell.identifier, for: indexPath) as? NaverImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(imageString: imageList[indexPath.row].link)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        selectImageAndPopView(link: imageList[index].link)
    }
    
}
