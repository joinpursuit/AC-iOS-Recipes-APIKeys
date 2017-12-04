//
//  RecipesViewController.swift
//  APIKeys-Recipies
//
//  Created by C4Q  on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var recipes = [Recipe]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var searchTerm = "" {
        didSet {
            loadRecipes(named: searchTerm)
        }
    }
    
    func loadRecipes(named str: String) {
        let setRecipes = {(onlineRecipes: [Recipe]) in
            self.recipes = onlineRecipes
        }
        let printErrors = {(error: Error) in
            print(error)
        }
        RecipeAPIClient.manager.getRecipes(named: str,
                                           completionHandler: setRecipes,
                                           errorHandler: printErrors)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.searchBar.delegate = self
    }
}

extension RecipesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Recipe Cell", for: indexPath)
        let recipe = self.recipes[indexPath.row]
        cell.textLabel?.text = recipe.name
        cell.detailTextLabel?.text = recipe.source
        return cell
    }
}

extension RecipesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text ?? ""
    }
}
