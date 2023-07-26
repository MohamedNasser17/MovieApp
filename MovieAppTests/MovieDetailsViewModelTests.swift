//
//  MovieDetailsViewModelTests.swift
//  MovieAppTests
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import XCTest
@testable import MovieApp

final class MovieDetailsViewModelTests: XCTestCase {
    
    var imageBaseURL: String!
    var movieDetails: MovieDetails!
    var movieDetailsViewModel: MovieDetailsViewModel!
    var networkService: MockNetworkService<MovieDetails>!
    
    override func setUp() {
        imageBaseURL = "imageBaseURL"
        movieDetails = MockedModels().movieDetails
        networkService = MockNetworkService(item: movieDetails)
        movieDetailsViewModel = MovieDetailsViewModel(movieId: movieDetails.id,
                                                      mainQueue: MockDispatchQueue(),
                                                      imageBaseURL: imageBaseURL,
                                                      networkService: networkService)
    }

    override func tearDown() {
        imageBaseURL = nil
        movieDetails = nil
        networkService = nil
        movieDetailsViewModel = nil
    }

    func testBackdropURLWhenBackdropPathIsNotEmpty() throws {
        // Given
        movieDetailsViewModel.fetchMovieDetails()
        let expectedURL = URL(string: "imageBaseURL\(movieDetails.backdropPath ?? "")")
        
        // When
        let backdropURL = movieDetailsViewModel.backdropURL
        
        // Then
        XCTAssertEqual(backdropURL, expectedURL)
    }

    func testBackdropURLWhenBackdropPathIsEmpty() throws {
        // Given
        movieDetails = MovieDetails(
            id: 2,
            runtime: 30,
            title: "Movie Title",
            genres: [Genre(id: 1, name: "Action"),
                     Genre(id: 2, name: "Comdy")],
            overview: "OverView",
            posterPath: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
            releaseDate: "2023-12-12",
            backdropPath: nil
        )
        networkService = MockNetworkService(item: movieDetails)
        movieDetailsViewModel = MovieDetailsViewModel(movieId: movieDetails.id,
                                                      mainQueue: MockDispatchQueue(),
                                                      imageBaseURL: imageBaseURL,
                                                      networkService: networkService)
        movieDetailsViewModel.fetchMovieDetails()
        let expectedURL = URL(string: "imageBaseURL\(movieDetails.posterPath ?? "")")
        
        // When
        let backdropURL = movieDetailsViewModel.backdropURL
        
        // Then
        XCTAssertEqual(backdropURL, expectedURL)
    }
    
    func testShowingAlertWhenFetchMovieDetailsSuccess() throws {
        // Given
        movieDetailsViewModel.fetchMovieDetails()
        
        // When
        let showingAlert = movieDetailsViewModel.showingAlert
        
        // Then
        XCTAssertEqual(showingAlert, false)
    }
    
    func testShowingAlertWhenFetchMovieDetailsFails() throws {
        // Given
        networkService.shouldSuccess = false
        movieDetailsViewModel = MovieDetailsViewModel(movieId: movieDetails.id,
                                                      mainQueue: MockDispatchQueue(),
                                                      imageBaseURL: imageBaseURL,
                                                      networkService: networkService)
        movieDetailsViewModel.fetchMovieDetails()
        
        // When
        let showingAlert = movieDetailsViewModel.showingAlert
        
        // Then
        XCTAssertEqual(showingAlert, true)
    }
    
    func testMovieDuration() throws {
        // Given
        movieDetailsViewModel.fetchMovieDetails()
        let expectedMovieDuration = "30 mins"
        
        // When
        let movieDuration = movieDetailsViewModel.movieDuration
        
        // Then
        XCTAssertEqual(movieDuration, expectedMovieDuration)
    }
    
    func testMovieDetails() throws {
        // Given
        movieDetailsViewModel.fetchMovieDetails()
        let expectedMovieDetails = movieDetails
        
        // When
        let movieDetails = movieDetailsViewModel.movieDetails
        
        // Then
        XCTAssertEqual(movieDetails?.id ?? 0, expectedMovieDetails?.id)
    }
    
    func testFetchMovieDetails() throws {
        // Given
        let expectedMovieDetails = movieDetails
        XCTAssertNil(movieDetailsViewModel.movieDetails)
        
        // When
        movieDetailsViewModel.fetchMovieDetails()
        let movieDetails = movieDetailsViewModel.movieDetails
        
        // Then
        XCTAssertEqual(movieDetails?.id ?? 0, expectedMovieDetails?.id)
    }
}
