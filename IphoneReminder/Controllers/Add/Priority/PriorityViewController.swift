//
//  PriorityViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

class PriorityViewController: BaseViewController {
    lazy var segmentedControl = UISegmentedControl(items: setItem())
    var priorityList = Priority.allCases
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let priorityIndex = segmentedControl.selectedSegmentIndex
        NotificationCenter.default.post(name: NSNotification.Name("setPriority"), object: nil, userInfo: ["priority": priorityList[priorityIndex].title])
    }
    
    private func setItem() -> [String] {
        var items: [String] = []
        for priority in priorityList {
            items.append(priority.title)
        }
        return items
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "우선 순위"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func configureHierarchy() {
        view.addSubview(segmentedControl)
    }
    func configureLayout() {
        segmentedControl.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.centerY.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    func configureView() {
        view.backgroundColor = ColorStyle.darkBlack
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.overrideUserInterfaceStyle = .dark
    }
}
