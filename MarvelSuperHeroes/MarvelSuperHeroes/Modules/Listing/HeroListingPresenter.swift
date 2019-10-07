//
//  HeroListingPresenter.swift
//  MarvelSuperHeroes
//
//  Created by Felipe Ramon de Lara on 06/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import Foundation

final class HeroListingPresenter{
    
    unowned private var view: HeroListingViewInterface
    private var heroes = [Hero]()
    private var offset = 0
    
    init(view: HeroListingViewInterface) {
        self.view = view
    }
}

extension HeroListingPresenter: HeroListingPresenterInterface{
    func shouldLoadMore() {
        self.fetch()
    }
    
    func viewDidFinishLoading() {
        //Ready to load some data
        self.fetch()
    }
    
    func fetch(){
        self.view.showLoading()
        SuperHeroesService.fetchSuperHeroes(offset: offset, onCompletion: { (response, error) in
            DispatchQueue.main.async { [unowned self] in
                self.view.hideLoading()

                guard let response = response,
                    let data = response.data,
                    let results = data.results else{
                        self.view.alert(title: "Whoops", message: "Could not load data. Please check your connection and try again.", completion: {})
                        return
                }
                
                self.offset += results.count
                self.heroes.append(contentsOf: results)
                self.view.updateViewWithData(heroes: self.heroes)
            }
        })
    }
}
