//
//  ColorItem.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/22/24.
//

import Foundation

enum ColorItem: Int, CaseIterable {
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case brown
    
    var name: String {
        switch self {
        case .red: return "customRed"
        case .orange: return "customOrange"
        case .yellow: return "customYellow"
        case .green: return "customGreen"
        case .blue: return "customBlue"
        case .purple: return "customPurple"
        case .brown: return "customBrown"
        }
    }
}
