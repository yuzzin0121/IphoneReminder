//
//  DeadLineDateViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

class DeadLineDateViewController: BaseViewController {
    let mainView = DeadLineDateView()
    var deadLineDate: Date? = nil
    var completionHandler: ((Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItem()
        setValue()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let selectedDate: Date = mainView.datePicker.date
//        let dateString = changeFormat(date: selectedDate)
        completionHandler?(selectedDate)
    }
    
    func setValue() {
        if let deadLineDate {
            mainView.datePicker.date = deadLineDate
        }
    }
    
    func changeFormat(date: Date) -> String? {
        // 선택된 날짜를 문자열로 변환하여 출력
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 원하는 날짜 형식 지정
        return dateFormatter.string(from: date)
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "마감일"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
