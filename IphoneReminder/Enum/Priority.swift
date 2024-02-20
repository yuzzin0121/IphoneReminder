//
//  Priority.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/20/24.
//

import Foundation

enum Priority: Int, CaseIterable {
    case low
    case middle
    case high
    
    var title: String {
        switch self {
        case .low: return "하"
        case .middle: return "중"
        case .high: return "상"
        }
    }
}
