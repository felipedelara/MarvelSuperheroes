//
//  ListingInterfaces.swift
//  MarvelSuperHeroes
//
//  Created by Felipe Ramon de Lara on 06/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import Foundation

protocol ListingViewToPresenterInterface {
    func didFinishLoading()
}

protocol ListingPresenterToViewInterface : class{
    func showLoading()
    func hideLoading()
    func updateViewWithData()
}

//
//protocol ListingPresenterToInteractorInterface {
//    func fetchHeroList(page:Int)
//}
//
//protocol ListingInteractorToPresenterInterface{
//    func didFetchHeroes(heroes: [String])
//    func didFailFetchingHeroes(error: Error)
//}
