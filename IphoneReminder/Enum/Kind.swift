//
//  Kind.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/19/24.
//

import UIKit

enum Kind: Int, CaseIterable {
    case today
    case schedule
    case total
    case flag
    case completed
    
    var fetchValue: String {
        switch self {
        case .today: return "deadLineDate"
        case .schedule: return ""
        case .total: return ""
        case .flag: return ""
        case .completed: return "isCompleted"
        }
    }
    
    var title: String {
        switch self {
        case .today: return "오늘"
        case .schedule: return "예정"
        case .total: return "전체"
        case .flag: return "깃발 표시"
        case .completed: return "완료됨"
        }
    }
    
    var iconImage: UIImage {
        switch self {
        case .today:
            return ImageStyle.lightbulb
        case .schedule:
            return ImageStyle.calendar
        case .total:
            return ImageStyle.tray
        case .flag:
            return ImageStyle.flag
        case .completed:
            return ImageStyle.checkmark
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .today:
            return .systemBlue
        case .schedule:
            return .systemRed
        case .total:
            return .darkGray
        case .flag:
            return .systemYellow
        case .completed:
            return .systemOrange
        }
    }
}
