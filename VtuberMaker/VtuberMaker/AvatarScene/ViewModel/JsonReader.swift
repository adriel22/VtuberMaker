//
//  JsonReader.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 16/10/22.
//

import Foundation
struct JsonReader {
    func getJson<T: Codable>(named jsonName: String, withType type: T.Type) -> T? {
        if let path = Bundle.main.path(forResource: jsonName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let decoder = JSONDecoder()
                let jsonResult = try decoder.decode(type, from: data)
                return jsonResult
                
            } catch {
                print("error:\(error)")
            }
        }
        
        return nil
    }
}
