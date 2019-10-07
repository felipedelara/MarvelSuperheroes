//
//  HeroListingViewController.swift
//  MarvelSuperHeroes
//
//  Created by Felipe Ramon de Lara on 06/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import UIKit

final class HeroListingViewController: UIViewController {
    
    private lazy var presenter : HeroListingPresenter = { [unowned self] in
        return HeroListingPresenter(view: self)
        }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = { [unowned self] in
        var indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
        indicator.isHidden = true
        self.view.addSubview(indicator)
        return indicator
    }()
    
    @IBOutlet weak var tableView: UITableView!

    private var heroes : [Hero] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        

        self.presenter.viewDidFinishLoading()
    }
   
}

extension HeroListingViewController : HeroListingViewInterface{
    func updateViewWithData(heroes: [Hero]) {
        self.heroes = heroes
        self.tableView.reloadData()
    }
    
    func alert(title: String, message: String, completion: @escaping () -> Void) {
        //
    }
    
    func showLoading() {
        print("I should start loading data")
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
}

extension HeroListingViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroTableViewCell", for: indexPath) as? HeroTableViewCell else{
            return UITableViewCell()
        }
        guard let hero = self.heroes[safe: indexPath.row],
            let heroName = hero.name else{
                return cell
        }
        cell.nameLabel.text = heroName
        
        return cell
    }
    
    
}
