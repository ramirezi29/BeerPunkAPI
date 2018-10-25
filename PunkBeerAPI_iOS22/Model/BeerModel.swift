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
    
    // NOTE: - Computer Property to grab our ingredients
    //
    
    var ingredientsString: String {
     
        var ingredientsArray: [String] = []
        for malt in ingredients.malts {
            ingredientsArray.append(malt.name)
    }
        // NOTE: -  seperator: "camma space"
           // classy way -> Compact Map
        return ingredients.malts.compactMap {$0.name}.joined(separator: ", ")
    }
    
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

//var ingredientsString: String {
//
//
//    //Brute Force -> for loop
//    var ingredientsArray: [String] = []
//    for malt in ingredients.malts {
//        ingredientsArray.append(malt.name)
//    }
//    // NOTE: -  seperator: "camma space"
//    return ingredientsArray.joined(separator: ", ")
//}
