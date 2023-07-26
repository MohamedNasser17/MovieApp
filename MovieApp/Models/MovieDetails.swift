//
//  MovieDetails.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation

struct MovieDetails: Codable, Identifiable {
    let id: Int
    let runtime: Int
    let title: String
    let genres: [Genre]
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case genres
        case runtime
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
