//
//  MemoViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

class MemoViewController: UIViewController {
    let mainView = MemoView()
    var memoTitle: String? = nil
    var memo: String? = nil
    var completionHandler: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItem()
        setValue()
    }
    
    private func setValue() {
        if let memoTitle {
            mainView.titleTextField.text = memoTitle
        }
        if let memo {
            mainView.contentTextField.text = memo
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.titleTextField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        completionHandler?(mainView.titleTextField.text!, mainView.contentTextField.text!)
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "메모"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func loadView() {
        view = mainView
    }
}
