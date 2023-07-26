//
//  MockNetworkService.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation

struct MockNetworkService<Item>: NetworkService {
    let item: Item
    
    func fetch<Element>(from endPoint: Endpoint, completion: @escaping (Result<Element, Error>) -> Void) where Element : Decodable {
        if let element = item as? Element {
            completion(.success(element))
        }
    }
}
