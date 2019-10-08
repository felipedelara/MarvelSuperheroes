//
//  HeroListingPresenter.swift
//  MarvelSuperHeroes
//
//  Created by Felipe Ramon de Lara on 06/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import Foundation

final class HeroListingPresenter{
    
    // MARK: - Private properties
    unowned private var view: HeroListingViewInterface
    private var heroes = [Hero]()
    private var offset = 0
    private var queryName : String? = nil
    
    init(view: HeroListingViewInterface) {
        self.view = view
    }
}

// MARK: - Presenter Interface
extension HeroListingPresenter: HeroListingPresenterInterface{
    func userDidSelectRow(row: Int) {
        guard let hero = self.heroes[safe: row] else{
            return
        }
        self.view.showDetail(hero: hero)
    }
    
    func searchQueryCanceled() {
        self.offset = 0
        self.queryName = nil
        self.heroes.removeAll()
        self.fetch()
    }
    
    func shouldSearchWithQuery(name: String) {
        self.offset = 0
        self.queryName = name
        self.heroes.removeAll()
        self.fetch()
    }
    
    func showFavouriteRequested() {
        guard let favouriteHeroJson  = UserDefaults.standard.string(forKey: "FavoriteHeroJson") else{
            self.view.alert(title: "Error", message: "You don't have a favourite super hero yet.", completion: {})
            return
        }
        
        guard let hero = try? Hero(favouriteHeroJson) else{
            self.view.alert(title: "Error", message: "Could not load super hero.", completion: {})
            return
        }
        
        self.view.showDetail(hero: hero)
    }
    
    func shouldLoadMore() {
        self.fetch()
    }
    
    func viewDidFinishLoading() {
        self.fetch()
    }
    
    func fetch(){
        self.view.showLoading()
        SuperHeroesService.fetchSuperHeroes(offset: offset, name: queryName, onCompletion: { (response, error) in
            DispatchQueue.main.async { [unowned self] in
                self.view.hideLoading()
                
                guard let response = response,
                    let data = response.data,
                    let results = data.results else{
                        self.view.alert(title: "Whoops", message: "Could not load data.", completion: {})
                        return
                }
                if results.count == 0{
                    self.view.alert(title: "No results found", message: "Your search could not retrieve any more results.", completion: {})
                    return
                }
                
                self.offset += results.count
                self.heroes.append(contentsOf: results)
                self.view.updateViewWithData(heroes: self.heroes)
            }
        })
    }
}
