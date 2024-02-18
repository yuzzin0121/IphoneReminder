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
            return ImageStyle.lightbulbCircleFill
        case .schedule:
            return ImageStyle.calendarCircleFill
        case .total:
            return ImageStyle.trayCircleFill
        case .flag:
            return ImageStyle.flagCircleFill
        case .completed:
            return ImageStyle.checkmarkCircleFill
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .today:
            return .blue
        case .schedule:
            return .systemRed
        case .total:
            return .gray
        case .flag:
            return .yellow
        case .completed:
            return .orange
        }
    }
}
