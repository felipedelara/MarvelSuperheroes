//
//  HeroDetailPresenter.swift
//  MarvelSuperHeroes
//
//  Created by Felipe Ramon de Lara on 07/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import Foundation

final class HeroDetailsPresenter{
    
    // MARK: - Private properties
    unowned private var view: HeroDetailsViewInterface
    private var hero : Hero
    
    init(view: HeroDetailsViewInterface, hero: Hero) {
        self.view = view
        self.hero = hero
    }
}

// MARK: - Presenter Interface
extension HeroDetailsPresenter : HeroDetailsPresenterInterface{
    func viewDidFinishLoading() {
        let favouriteHeroId = UserDefaults.standard.integer(forKey: "FavoriteHeroId")
        let isFavourite = favouriteHeroId == self.hero.id

        let viewModel = HeroDetailViewModel(hero: hero, isFavourite: isFavourite)
        self.view.updateViewWith(viewModel: viewModel)
    }
    
    func shouldMarkAsFavorite() {
        guard let heroJson = try? hero.jsonString(),
            let id = hero.id,
            let name = hero.name else{
            self.view.alert(title: "Error", message: "Could not save hero as favorite", completion: {})
            return
        }
        
        UserDefaults.standard.set(id, forKey: "FavoriteHeroId")
        UserDefaults.standard.set(heroJson, forKey: "FavoriteHeroJson")

        self.view.alert(title: "Done", message: "\(name) is now set as your favourite hero", completion: {})
    }
}
