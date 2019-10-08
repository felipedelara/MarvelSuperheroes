//
//  String.swift
//  MarvelSuperHeroes
//
//  Created by Felipe Ramon de Lara on 08/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import Foundation

extension String {
    var filtered: String {
        let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        return simple.components(separatedBy: nonAlphaNumeric).joined(separator: "")
    }
}
