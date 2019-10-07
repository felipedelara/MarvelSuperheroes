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
    
    private var loadingView = UIView()
    private var indicator = UIActivityIndicatorView()
    
    @IBOutlet weak var tableView: UITableView!

    private var heroes : [Hero] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.setupLoadingView()
        self.presenter.viewDidFinishLoading()
    }
   
    func setupLoadingView(){
        self.loadingView = UIView(frame: self.view.frame)
        self.loadingView.backgroundColor = UIColor.white.withAlphaComponent(0.65)
        self.loadingView.center = self.view.center
        self.loadingView.isHidden = true
        
        
        self.indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        
        self.indicator.center = self.loadingView.center
        self.indicator.isHidden = true
        self.indicator.hidesWhenStopped = true
        self.loadingView.addSubview(indicator)
        
        self.view.addSubview(loadingView)
    }
    
    @IBAction func loadMoreButtonPressed(_ sender: Any) {
        self.presenter.shouldLoadMore()
    }
}

extension HeroListingViewController : HeroListingViewInterface{
    func updateViewWithData(heroes: [Hero]) {
        self.heroes = heroes
        self.tableView.reloadData()
    }
    
    func alert(title: String, message: String, completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
                completion()
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showLoading() {
        print("I should start loading data")
        DispatchQueue.main.async {
            self.loadingView.isHidden = false
            self.indicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
            self.indicator.stopAnimating()
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
