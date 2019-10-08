//
//  HeroListingViewController.swift
//  MarvelSuperHeroes
//
//  Created by Felipe Ramon de Lara on 06/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import UIKit

final class HeroListingViewController: UIViewController, UISearchControllerDelegate {
    
    // MARK: - Private properties
    private lazy var presenter : HeroListingPresenter = { [unowned self] in
        return HeroListingPresenter(view: self)
        }()
    private var loadingView = UIView()
    private var indicator = UIActivityIndicatorView()
    private var heroes : [Hero] = []
    private let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.setupLoadingView()
        self.setupSearchController()
        self.presenter.viewDidFinishLoading()
    }
    
    // MARK: - Setups
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
    
    func setupSearchController(){
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by name"
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        definesPresentationContext = true
    }
    
    // MARK: - Actions
    @IBAction func loadMoreButtonPressed(_ sender: Any) {
        self.presenter.shouldLoadMore()
    }
    
    @IBAction func showFavouriteButtonPressed(_ sender: Any) {
        self.presenter.showFavouriteRequested()
    }
}

// MARK: - View Interface 
extension HeroListingViewController : HeroListingViewInterface{
    func showDetail(hero: Hero) {
        self.showDetailViewController(HeroDetailsViewController.create(hero: hero), sender: self)
    }
    
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

// MARK: - Table View
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.userDidSelectRow(row: indexPath.row)
    }
}

// MARK: - SearchBar
extension HeroListingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else{
            return
        }
        self.presenter.shouldSearchWithQuery(name: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presenter.searchQueryCanceled()
    }
}
