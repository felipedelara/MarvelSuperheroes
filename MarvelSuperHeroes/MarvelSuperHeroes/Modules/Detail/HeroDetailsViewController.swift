//
//  HeroDetailsViewController.swift
//  MarvelSuperHeroes
//
//  Created by Felipe Ramon de Lara on 07/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import UIKit

class HeroDetailsViewController: UIViewController {

    private var presenter : HeroDetailsPresenter?
    
    private var loadingView = UIView()
    private var indicator = UIActivityIndicatorView()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    
    
    static func create(hero: Hero) -> HeroDetailsViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeroDetailViewController") as! HeroDetailsViewController

        viewController.presenter = HeroDetailsPresenter(view: viewController, hero: hero)
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidFinishLoading()
    }
    
    @IBAction func makeFavoriteButtonPressed(_ sender: Any) {
        self.presenter?.shouldMarkAsFavorite()
    }
}

extension HeroDetailsViewController : HeroDetailsViewInterface{
    func updateViewWith(viewModel: HeroDetailViewModel) {
        self.nameLabel.text = viewModel.name
        self.detailsTextView.text = viewModel.details
    }
    
    func alert(title: String, message: String, completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
                completion()
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
