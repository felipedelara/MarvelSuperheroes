//
//  SuperHeroesService.swift
//  MarvelSuperHeroes
//
//  Created by Felipe Ramon de Lara on 06/10/19.
//  Copyright © 2019 Felipe de Lara. All rights reserved.
//

import Foundation

enum ServiceError : Error{
    case regularError(error: Error)
    case decodeError
    case requestError
    case authenticationError
}

class SuperHeroesService{
    static func fetchSuperHeroes(offset: Int, onCompletion : @escaping (SuperHeroesResponse?, ServiceError?) -> Void){
        let ts = Date().toMillis()
        let apiKey = "fb620164db72040935834ad11d1529a7"
        let privateKey = "ff101cbd6fac69f3f260575202d3dcfa337e6264"
        
        // md5(ts+privateKey+publicKey)
        let toHash = "\(ts)\(privateKey)\(apiKey)"
        let hash = MD5(string: toHash)
        let md5Hex =  hash.map { String(format: "%02hhx", $0) }.joined()

        let request = NSMutableURLRequest(url: NSURL(string: "https://gateway.marvel.com:443/v1/public/characters?ts=\(ts)&apikey=\(apiKey)&hash=\(md5Hex)&offset=\(offset)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error{
                onCompletion(nil, ServiceError.regularError(error: error))
                return
            }
            
            guard let data = data,
                let superHeroesResponse = try? SuperHeroesResponse(data: data) else{
                //Error
                onCompletion(nil, ServiceError.decodeError)
                return
            }            
            onCompletion(superHeroesResponse, nil)
        })

        dataTask.resume()
    }
}
