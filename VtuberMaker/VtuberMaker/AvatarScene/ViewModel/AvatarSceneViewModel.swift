//
//  AvatarSceneViewModel.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 19/09/22.
//

import Foundation
final class AvatarSceneViewModel {
    
    private let jsonReader = JsonReader()
    private var assetsData: [AssetData]
    
    init(avatarModel: AvatarModel) {
        assetsData = jsonReader.getJson(named: "AssetsConfig", withType: [AssetData].self) ?? []
    }
    
    func getAssets(ofSection section: Int) -> [Asset] {
        return assetsData[section].assets
    }
    
    func getAsset(forSection section: Int, _ item: Int) -> Asset{
        return assetsData[section].assets[item]
    }
    
    func getAssetsTypes() -> [AssetType] {
        return assetsData.compactMap({$0.type})
    }
    
    func getType(ofSection section: Int) -> String {
        return assetsData[section].type.rawValue
    }
}
