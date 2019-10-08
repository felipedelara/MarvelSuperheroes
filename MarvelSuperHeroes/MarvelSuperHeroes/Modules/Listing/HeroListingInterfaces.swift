//
//  ListingInterfaces.swift
//  MarvelSuperHeroes
//
//  Created by Felipe Ramon de Lara on 06/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import Foundation

protocol HeroListingViewInterface : class {
    //Presenter to View
    func showLoading()
    func hideLoading()
    func updateViewWithData(heroes: [Hero])
    func alert(title: String, message: String, completion: @escaping ()->Void)
    func showDetail(hero: Hero)
}

protocol HeroListingPresenterInterface : class {
    //View to Presenter
    func viewDidFinishLoading()
    func shouldLoadMore()
    func showFavouriteRequested()
}
