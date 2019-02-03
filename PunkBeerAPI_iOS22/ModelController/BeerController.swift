//
//  BeerController.swift
//  PunkBeerAPI_iOS22
//
//  Created by Ivan Ramirez on 10/25/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation
import UIKit


class BeerController {
    
    static let baseURL = URL(string: "https://api.punkapi.com/v2/beers")
    
    // MARK: - Fetc Func for beers
    
    typealias fetchBeersCompletion = ([Beer]?) -> Void
    
    static func getBeerForFood(byUsing food: String, completion: @escaping  fetchBeersCompletion) {
        
        // Step 1 - Construct the URL
        guard let unwrappedURL = baseURL else {completion(nil); return}
        
        // Step: Create our URL Components bc we need a URL Query ITem
        var components = URLComponents(url: unwrappedURL, resolvingAgainstBaseURL: true)
        
        // ****
        /*API Documentation: parameter 'food', Returns all beers matching the supplied food string, this performs a fuzzy match, if you need to add spaces just add an underscore (_).*/
        
        // NOTE: - Need to account for spaces in the search term. If they search "Chicken Nuggets" its going to create an array
        // Example - "chicken Nugets with bbq sauce"
        // The compiler is smart enough to still work with only one item in the search field
        let foodSpacecomponents = food.components(separatedBy: " ")
        
        // Example: ["chicken", "nuggets", "with", "bbq", "sauce]
        // now there are no sperates
        // with the code below 'joined(sep....) we join the array with an under score
        // Example: end result  {"chicken_nuggets_with......"}
        let foodSearchTermWithPotentialUnderScore = foodSpacecomponents.joined(separator: "_")
        // ****
        
        // Step: Create our Query Items
        let foodQueryItem = URLQueryItem(name: "food", value: foodSearchTermWithPotentialUnderScore)
        
        components?.queryItems = [foodQueryItem]
        
        guard let builtURL = components?.url else {completion(nil); return}
        print(builtURL.absoluteString)
        
        // Step 3 - Data Task + Resume
        URLSession.shared.dataTask(with: builtURL) { (data, _, error) in
            if let error = error {
                print("\n\n🚀 There was an error with fetching beers via dataTask in: \(#file) \n\n \(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil); return
            }
            guard let data = data else { print("Bad Data")
                return
            }
            
            do{
                // NOTE: - This takes in a generic type with '.decode' in documentation its a <T>. Hey what ever you decode, its of type beer. 
                let beersFromWeb = try JSONDecoder().decode([Beer].self, from: data)
                completion(beersFromWeb)
            } catch {
                print("\n\n🚀 There was an error with decoding the data in: \(#file) \n\n \(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil); return
            }
            }.resume()
    }
    
    // MARK: - Fetch Image
    
    typealias FetchImageCompletion = (UIImage?) -> Void
    
    static func getImage(for beer: Beer, completion: @escaping FetchImageCompletion) {
        
        // Step 1 Construct the URL
        guard let unwrappedURL = beer.imageURL else {completion(nil); return}
        
        // Step 2 Request *SKipped
        // Step 3 DataTask + Resume
        URLSession.shared.dataTask(with: unwrappedURL) { (data, _, error) in
            if let error = error {
                print("\n\n🚀 There was an error with fething the image in: \(#file) \n\n \(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil); return}
            let image = UIImage(data: data)
            completion(image)
            }.resume()
    }
}
