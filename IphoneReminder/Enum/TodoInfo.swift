//
//  TodoInfo.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/20/24.
//

import Foundation

enum TodoInfo: Int, CaseIterable {
    case memo
    case deadLineDate
    case tag
    case priority
    case addImage
    case list
    
    var title: String {
        switch self {
        case .memo: return ""
        case .deadLineDate: return "마감일"
        case .tag: return "태그"
        case .priority: return "우선 순위"
        case .addImage: return "이미지 추가"
        case .list: return "목록"
        }
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .memo: return 150
        case .deadLineDate, .tag, .priority, .addImage, .list:
            return 54
        }
    }
}
