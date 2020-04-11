//
//  Model.swift
//  MyNewCar
//
//  Created by Vinay Raj K on 11/04/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import Foundation


struct Movie: Decodable {
    let score: Double
    let show: Show
}

struct Show : Decodable {
    let id: Int
    let url: String
    let name: String
    let type: String
    let language: String
    let genres: [String]
    let status: String
    let runtime: Int
    let premiered: String
    let officialSite: String?
    let rating: Rating?
    let weight: Int
    let image: Image?
    let summary: String
    let updated: Int
}

struct Image: Decodable {
    let medium, original: String
}

struct Rating: Decodable {
    let average: Double?
}
