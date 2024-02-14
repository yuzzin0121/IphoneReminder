//
//  MemoView.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit
import SnapKit

class MemoView: BaseView {
    let titleTextField = DarkTextField()
    let contentTextField = DarkTextField()
    
    let titlePlaceholder = "제목을 입력하세요"
    let contentPlaceholder = "내용을 입력하세요"
    
    override func configureHierarchy() {
        [titleTextField, contentTextField].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(46)
        }
        contentTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(46)
        }
    }
    
    override func configureView() {
        backgroundColor = ColorStyle.darkBlack
        titleTextField.placeholder = titlePlaceholder
        titleTextField.attributedPlaceholder = NSAttributedString(string: titlePlaceholder,
                                                     attributes: [
                                                        .foregroundColor: UIColor.lightGray
                                                     ])
        
        contentTextField.placeholder = contentPlaceholder
        contentTextField.attributedPlaceholder = NSAttributedString(string: contentPlaceholder,
                                                     attributes: [
                                                        .foregroundColor: UIColor.lightGray
                                                     ])
    }
}
