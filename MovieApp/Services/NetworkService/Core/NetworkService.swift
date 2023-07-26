//
//  NetworkService.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation

protocol NetworkService {
    func fetch<Element: Decodable>(from endPoint: Endpoint, completion: @escaping (Result<Element, Error>) -> Void)
}

struct NetworkServiceImpl: NetworkService {
    func fetch<Element: Decodable>(from endPoint: Endpoint, completion: @escaping (Result<Element, Error>) -> Void) {
        
        var request = URLRequest(url: URL(string: endPoint.url)!)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields?["accept"] = "application/json"
        request.allHTTPHeaderFields?["authorization"] = "bearer \(Constants.authorizationToken)"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Element.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(NSError()))
                }
            }
        }.resume()
    }
}
