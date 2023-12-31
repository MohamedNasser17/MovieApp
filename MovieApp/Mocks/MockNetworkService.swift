//
//  MockNetworkService.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation

struct MockNetworkService<Item>: NetworkService {
    let item: Item
    var shouldSuccess: Bool = true
    
    func fetch<Element>(from endPoint: Endpoint, completion: @escaping (Result<Element, Error>) -> Void) where Element : Decodable {
        if let element = item as? Element, shouldSuccess {
            completion(.success(element))
        } else {
            completion(.failure(NSError()))
        }
    }
}
