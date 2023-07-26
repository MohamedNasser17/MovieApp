//
//  MovieDetailsEndPoint.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation

struct MovieDetailsEndPoint: Endpoint {
    let movieId: Int
    let baseURL: String
    
    init(baseURL: String = Constants.baseURL, movieId: Int) {
        self.baseURL = baseURL
        self.movieId = movieId
    }
    
    var url: String {
        "\(baseURL)movie/\(movieId)"
    }
    
    var method: NetworkMethod {
        .get
    }
}
