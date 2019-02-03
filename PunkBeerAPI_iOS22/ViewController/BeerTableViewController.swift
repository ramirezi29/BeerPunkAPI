//
//  BeerTableViewController.swift
//  PunkBeerAPI_iOS22
//
//  Created by Ivan Ramirez on 10/25/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class BeerTableViewController: UITableViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityViewOutlet: UIView!
    @IBOutlet weak var beerSearchBar: UISearchBar!
    
    // MARK: - Funte de Verdad
    var beers: [Beer] = []
    
    // MARK: - Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityViewOutlet.isHidden = true
        activityViewOutlet.backgroundColor = UIColor.clear
        beerSearchBar.delegate = self
        beerSearchBar.placeholder = "Enter Your Favorite Food"
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return beers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerCell", for: indexPath)
        
        let beer =  beers[indexPath.row]
        cell.textLabel?.text = beer.name
        cell.detailTextLabel?.text = beer.tagline
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            // Step: Get the destiantion and the index path that was tapped
            guard let destiantionVC = segue.destination as? BeerDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            // Step: Set Landing pad
            // refrence to the beers row
            let beer = beers[indexPath.row]
            destiantionVC.beer = beer
        }
    }
}

extension BeerTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let food = searchBar.text, !food.isEmpty else {return}
        
        DispatchQueue.main.async {
            self.activityViewOutlet.isHidden = false
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
        
        BeerController.getBeerForFood(byUsing: food) { (beers) in
            guard let beers = beers else {return}
            self.beers = beers
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityViewOutlet.isHidden = true
            }
        }
    }
}
