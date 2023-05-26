//
//  Order.swift
//  DejengOrderApp
//
//  Created by Alice on 2023/5/23.
//

import Foundation

struct OrderPost: Codable {
    let records: [List]
}

struct List: Codable {
    let fields: DrinkDetail
}

struct DrinkDetail: Codable {
    let name: String
    let size: String
    let ice: String
    let sugar: String
    let quantity: Int
    let totalPrice: Int
    let orderTime: String
    let additional: String
    let customerName: String
}
