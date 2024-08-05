//
//  TourData.swift
//  WhereToGo
//
//  Created by 권정근 on 8/5/24.
//

import Foundation

struct AttractionResponse: Codable {
    let response: ResponseBody
}

struct ResponseBody: Codable {
    let body: Body
}

struct Body: Codable {
    let items: Items
}

struct Items: Codable {
    let item: [Attraction]
}

struct Attraction: Codable {
    let addr1: String
    let firstimage: String
    let firstimage2: String
    let title: String
}
