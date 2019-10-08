//
//  HeroDetailViewModel.swift
//  MarvelSuperHeroes
//
//  Created by Felipe Ramon de Lara on 07/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import Foundation

struct HeroDetailViewModel{
    let name: String
    let details: String
    let isFavourite: Bool
    
    init(hero: Hero, isFavourite:Bool) {
        self.name = hero.name ?? "no name"
        
        var _details = ""
        if let description = hero.resultDescription,
            description != ""{
            _details.append("\(description)\n\n")
        }
        if let comics = hero.comics{
            _details.append("Comics: \(HeroDetailViewModel.listFirst3(appearances: comics))\n")
        }
        if let events = hero.events{
            _details.append("\nEvents: \(HeroDetailViewModel.listFirst3(appearances: events))\n")
        }
        if let stories = hero.stories{
            _details.append("\nStories: \(HeroDetailViewModel.listFirst3(appearances: stories))\n")
        }
        if let series = hero.series{
            _details.append("\nSeries: \(HeroDetailViewModel.listFirst3(appearances: series))\n")
        }
        self.details = _details
        
        self.isFavourite = isFavourite
    }
    
    static func listFirst3(appearances : Appearances) -> String{
        guard let items = appearances.items, items.count >= 1 else{
            return "No appearances for this category."
        }
        
        let maxIndex = items.count - 1
        let index = maxIndex < 2 ? maxIndex : 2
        let resultString = items[0...index].map{"\($0.name ?? "no name")"}.reduce(""){$0+"\n"+$1}
        return resultString
    }
}
