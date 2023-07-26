//
//  MockedModels.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation

struct MockedModels {
    var movieDetails: MovieDetails {
        MovieDetails(
            id: 2,
            runtime: 30,
            title: "Movie Title",
            genres: [Genre(id: 1, name: "Action"),
                     Genre(id: 2, name: "Comdy")],
            overview: "OverView",
            posterPath: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
            releaseDate: "2023-12-12",
            backdropPath: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg"
        )
    }
    
    var movie: Movie {
        Movie(
            id: 2,
            title: "Movie Title",
            posterPath: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
            releaseDate: "2023-12-12",
            backdropPath: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg"
        )
    }
    
    var moviesDiscoveryResponse: MoviesDiscoveryResponse {
        MoviesDiscoveryResponse(
            page: 1,
            results: [
                movie,
                movie
            ],
            totalResults: 2,
            totalPages: 1
        )
    }
}
