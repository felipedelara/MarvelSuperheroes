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
    func updateViewWithData()
}

protocol HeroListingPresenterInterface : class {
    //View to Presenter
    func viewDidFinishLoading()
}
