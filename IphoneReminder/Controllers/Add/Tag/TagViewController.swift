//
//  TagViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit
import SnapKit

class TagViewController: BaseViewController {
    let tagTextField = DarkTextField()
    let tagPlaceholder = "태그를 입력하세요"
    var tag: String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureHierarchy()
        configureLayout()
        configureView()
        setValue()
    }
    
    func setValue() {
        if let tag {
            tagTextField.text = tag
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tagTextField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let tagValue = tagTextField.text {
            NotificationCenter.default.post(name: NSNotification.Name("setTag"), object: nil, userInfo: ["tag":tagValue])
        }
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "태그"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func configureHierarchy() {
        view.addSubview(tagTextField)
    }
    func configureLayout() {
        tagTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(46)
        }
    }
    func configureView() {
        view.backgroundColor = ColorStyle.darkBlack
        tagTextField.placeholder = tagPlaceholder
        tagTextField.attributedPlaceholder = NSAttributedString(string: tagPlaceholder,
                                                     attributes: [
                                                        .foregroundColor: UIColor.lightGray
                                                     ])
    }
}
