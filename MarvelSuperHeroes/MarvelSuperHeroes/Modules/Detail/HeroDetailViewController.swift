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
        let comics = hero?.comics?.items?.map{"\($0.name!)"}.reduce(""){$0+"\n"+$1}
        let events = hero?.events?.items?.map{"\($0.name!)"}.reduce(""){$0+"\n"+$1}
        
        let detail = "Comics: \(comics!)\n\nEvents:\(events!)"
        detailsTextView.text = detail
    }
}
