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
    
    init(view: HeroListingViewInterface) {
        self.view = view
    }
}

extension HeroListingPresenter: HeroListingPresenterInterface{
    func viewDidFinishLoading() {
        //Ready to load some data
        self.view.showLoading()
        SuperHeroesService.fetchSuperHeroes { (response, error) in
            DispatchQueue.main.async { [unowned self] in
                guard let response = response,
                    let data = response.data,
                    let results = data.results else{
                        self.view.hideLoading()
                        self.view.alert(title: "Error", message: "Could not load data", completion: {})
                        return
                }
                self.view.updateViewWithData(heroes: results)
            }
        }
    }
}
