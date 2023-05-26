//
//  MenuResponse.swift
//  DejengOrderApp
//
//  Created by Alice on 2023/5/11.
//

import Foundation

struct MenuResponse: Codable {
    let records: [Record]
}
struct Record: Codable {
    let id: String
    let fields: Field
}
        
struct Field: Codable {
    let classification: String
    let name: String
    let medium: Int
    let large: String
}
