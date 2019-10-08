//
//  HeroDetailInterfaces.swift
//  MarvelSuperHeroesTests
//
//  Created by Felipe Ramon de Lara on 07/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import Foundation

protocol HeroDetailsViewInterface : class {
    //Presenter to View
    func updateViewWith(viewModel: HeroDetailViewModel)
    func alert(title: String, message: String, completion: @escaping ()->Void)
}

protocol HeroDetailsPresenterInterface : class {
    //View to Presenter
    func viewDidFinishLoading()
    func shouldMarkAsFavorite()
}
