//
//  HeroListingViewController.swift
//  MarvelSuperHeroes
//
//  Created by Felipe Ramon de Lara on 06/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import UIKit

final class HeroListingViewController: UIViewController {

    private lazy var presenter : HeroListingPresenter = { [unowned self ] in
        return HeroListingPresenter(view: self)
     }()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.viewDidFinishLoading()
    }
}

extension HeroListingViewController : HeroListingViewInterface{
    func showLoading() {
        //
    }
    
    func hideLoading() {
        //
    }
    
    func updateViewWithData() {
        //
    }
    
}
