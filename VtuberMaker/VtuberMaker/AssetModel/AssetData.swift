//
//  AvatarModel.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 16/08/22.
//

import Foundation

struct AssetData: Codable {
    let type: AssetType
    let assets: [Asset]
}

enum AssetType: String, Codable {
    case rightEye
    case leftEye
    case head
    case hair
    case mouth
    case nose
}

struct Asset: Codable {
    let thumbnail: String
    let file: String
}
