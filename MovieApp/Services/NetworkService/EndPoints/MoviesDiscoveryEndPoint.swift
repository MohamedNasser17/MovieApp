//
//  MoviesDiscoveryEndPoint.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation

struct MoviesDiscoveryEndPoint: Endpoint {
    let page: Int
    let baseURL: String
    
    init(baseURL: String = Constants.baseURL, page: Int) {
        self.baseURL = baseURL
        self.page = page
    }
    
    var url: String {
        "\(baseURL)discover/movie?page=\(page)"
    }
    
    var method: NetworkMethod {
        .get
    }
}
