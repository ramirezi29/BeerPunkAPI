//
//  BeerModel.swift
//  PunkBeerAPI_iOS22
//
//  Created by Ivan Ramirez on 10/25/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

struct Beer: Decodable {
    
    
    let name: String
    let tagline: String
    let imageURL: URL?
    let abv: Double
    
    let ingredients: Ingredients
    
    enum CodingKeys: String, CodingKey {
        case name
        case tagline
        case imageURL = "image_url"
        case abv
        case ingredients
    
    }
}
    
//    var ingredientNames: [String] {
//        return ingredients.map{$0.malts.name}
//    }
//}

   // NOTE: - ingredients is the key to a dictionary

struct Ingredients: Decodable {
    let malts: [Malt]
    
    enum CodingKeys: String, CodingKey {
        case malts = "malt"
    }
}

struct Malt: Decodable {
    let name: String
}
