//
//  HeroListingPresenter.swift
//  MarvelSuperHeroes
//
//  Created by Felipe Ramon de Lara on 06/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import Foundation

final class HeroListingPresenter{
    
    weak private var view: HeroListingViewInterface?
    
    init(view: HeroListingViewInterface) {
        self.view = view
    }
}

extension HeroListingPresenter: HeroListingPresenterInterface{
    func viewDidFinishLoading() {
        //
    }
    

}
