//
//  HeroDetailViewController.swift
//  MarvelSuperHeroes
//
//  Created by Felipe Ramon de Lara on 06/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    
    private var hero : Hero?
    
    static func create(hero: Hero) -> HeroDetailViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeroDetailViewController") as! HeroDetailViewController

        viewController.hero = hero
        return viewController
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = hero?.name
        
        var details = ""
        guard let hero = hero else{
            return
        }
        if let comics = hero.comics{
            details.append("\nComics: \(listFirst3(appearances: comics))\n")
        }
        if let events = hero.events{
            details.append("\nEvents: \(listFirst3(appearances: events))\n")
        }
        if let stories = hero.stories{
            details.append("\nStories: \(listFirst3(appearances: stories))\n")
        }
        if let series = hero.series{
            details.append("\nSeries: \(listFirst3(appearances: series))\n")
        }
        detailsTextView.text = details
    }
    @IBAction func makeFavoriteButtonPressed(_ sender: Any) {
    }
    
    
    func listFirst3(appearances : Appearances) -> String{
        guard let items = appearances.items, items.count >= 1 else{
            return "No appearances for this category."
        }
        
        let maxIndex = items.count - 1
        let index = maxIndex < 2 ? maxIndex : 2
        let resultString = items[0...index].map{"\($0.name ?? "no name")"}.reduce(""){$0+"\n"+$1}
        return resultString
    }
}
