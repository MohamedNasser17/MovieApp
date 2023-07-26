//
//  MoviesDiscoveryViewModel.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation
import SwiftUI

protocol MoviesDiscoveryViewModelProtocol: ObservableObject {
    var movies: [Movie] { get }
    var showingAlert: Bool { get }
    var selectedMovieID: Int { get set }
    func fetchNextPage()
    func fetchFirstPage()
}

class MoviesDiscoveryViewModel: MoviesDiscoveryViewModelProtocol {
    @Published private(set) var movies: [Movie] = []
    @Published private(set) var showingAlert: Bool = false
    
    private var totalPages: Int = 2
    private var currentPage: Int = 1
    private let imageBaseURL: String
    private let networkService: NetworkService
    private let semaphore: DispatchSemaphore = DispatchSemaphore(value: 1)
    
    var selectedMovieID = 0
    
    init(imageBaseURL: String = Constants.imageBaseURL,
         networkService: NetworkService = NetworkServiceImpl()) {
        self.imageBaseURL = imageBaseURL
        self.networkService = networkService
    }

    func fetchNextPage() {
        semaphore.wait()
        if currentPage + 1 <= totalPages {
            fetchMovies(page: currentPage + 1)
        }
    }

    func fetchFirstPage() {
        semaphore.wait()
        fetchMovies(page: 1)
    }
    
    private func fetchMovies(page: Int) {
        let endPoint = MoviesDiscoveryEndPoint(page: page)
        networkService.fetch(from: endPoint, completion: handleNetworkCompletion)
    }

    private func handleNetworkCompletion(result: Result<MoviesDiscoveryResponse, Error>) {
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let response):
                self?.movies.append(contentsOf: response.results)
                self?.currentPage = response.page
                self?.totalPages = response.totalPages
            case .failure:
                self?.showingAlert = true
            }
            self?.semaphore.signal()
        }
    }
}
