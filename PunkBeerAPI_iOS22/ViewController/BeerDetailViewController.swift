//
//  BeerDetailViewController.swift
//  PunkBeerAPI_iOS22
//
//  Created by Ivan Ramirez on 10/25/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    // MARK: - OUtlets
    
    @IBOutlet weak var apvLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerImageView: UIImageView!
    
    // MARK: - Landing Pad
    var beer: Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
        // NOTE: - Were going to call the fetch image cal in the ViewDidLaod
        guard let beer = beer else {return}
        BeerController.getImage(for: beer) { (image) in
            DispatchQueue.main.async {
                self.beerImageView.image = image
            }
        }
    }
    
    func updateViews() {
        guard let beer = beer else {return}
        beerNameLabel.text = beer.name
        apvLabel.text = "APV:\(beer.abv)"
        ingredientsLabel.text = "Ingredients: \(beer.ingredientsString)"
    }
}
