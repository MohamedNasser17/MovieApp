//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation
import SwiftUI

protocol MovieDetailsViewModelProtocol: ObservableObject {
    var backdropURL: URL? { get }
    var showingAlert: Bool { get }
    var movieDuration: String? { get }
    var movieDetails: MovieDetails? { get }
    func fetchMovieDetails()
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    @Published private(set) var movieDetails: MovieDetails?
    @Published private(set) var showingAlert: Bool = false

    private let networkService: NetworkService
    private let mainQueue: DispatchQueueType
    private let imageBaseURL: String
    private let movieId: Int
    
    init(movieId: Int,
         mainQueue: DispatchQueueType = DispatchQueue.main,
         imageBaseURL: String = Constants.imageBaseURL,
         networkService: NetworkService = NetworkServiceImpl()) {
        self.movieId = movieId
        self.mainQueue = mainQueue
        self.imageBaseURL = imageBaseURL
        self.networkService = networkService
    }

    var backdropURL: URL? {
        if let backdropPath = movieDetails?.backdropPath {
            return URL(string: "\(imageBaseURL)\(backdropPath)")!
        } else if let posterPath = movieDetails?.posterPath {
            return URL(string: "\(imageBaseURL)\(posterPath)")!
        }
        return nil
    }
    
    var movieDuration: String? {
        if let runtime = movieDetails?.runtime {
            return "\(runtime) mins"
        }
        return nil
    }

    func fetchMovieDetails() {
        let endPoint = MovieDetailsEndPoint(movieId: movieId)
        networkService.fetch(from: endPoint, completion: handleNetworkCompletion)
    }
    
    private func handleNetworkCompletion(result: Result<MovieDetails, Error>) {
        mainQueue.async { [weak self] in
            switch result {
            case .success(let movieDetails):
                self?.movieDetails = movieDetails
            case .failure:
                self?.showingAlert = true
            }
        }
    }
}

