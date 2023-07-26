//
//  Movie.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
    }
}
