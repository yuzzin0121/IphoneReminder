//
//  NaverImageModel.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/20/24.
//

import Foundation

struct NaverImageModel: Decodable {
    let total: Int
    let start: Int
    let items: [NaverImage]
}

struct NaverImage: Decodable {
    let link: String
}
