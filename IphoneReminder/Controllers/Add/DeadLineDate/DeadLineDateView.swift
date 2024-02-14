//
//  DeadLineDateView.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit
import SnapKit

class DeadLineDateView: BaseView {
    let datePicker = UIDatePicker()
    
    override func configureHierarchy() {
        addSubview(datePicker)
    }
    
    override func configureLayout() {
        datePicker.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.centerY.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = ColorStyle.darkBlack
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.preferredDatePickerStyle = .inline
        datePicker.tintColor = .white
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
    }
}

