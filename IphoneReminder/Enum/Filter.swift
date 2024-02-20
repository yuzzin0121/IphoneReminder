//
//  Filter.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/20/24.
//

import Foundation

enum Filter: Int, CaseIterable {
    case total
    case deadLine
    case title
    case lowPriority
    case highPriority
    
    var title: String {
        switch self {
        case .total: return "전체 보기"
        case .deadLine: return "마감일 순으로 보기"
        case .title: return "제목 순으로 보기"
        case .lowPriority: return "우선순위 낮음 만 보기"
        case .highPriority: return "우선순위 높음 만 보기"
        }
    }
    
    var sortKey: String {
        switch self {
        case .total: return "createdAt"
        case .deadLine: return "deadLineDate"
        case .title: return "title"
        case .lowPriority: return "하"
        case .highPriority: return "상"
        }
    }
}
