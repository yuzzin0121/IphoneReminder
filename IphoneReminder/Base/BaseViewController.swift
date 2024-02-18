//
//  BaseViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/14/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationController?.setupBarAppearence()
    }

    func showAlert(title: String, message: String, action: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            action()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

}
