//
//  MoviesDiscoveryView.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import SwiftUI

struct MoviesDiscoveryView<ViewModel>: View where ViewModel: MoviesDiscoveryViewModelProtocol {
    @ObservedObject var viewModel: ViewModel
    @State private var isPresented = false
    
    var body: some View {
        GeometryReader { proxy in
            List {
                ForEach(viewModel.movies, id: \.id) { movie in
                    MoviesDiscoveryCardView(movie: movie, size: proxy.size)
                        .onTapGesture {
                            viewModel.selectedMovieID = movie.id
                            isPresented.toggle()
                        }
                        .onAppear {
                            if movie.id == viewModel.movies.last?.id {
                                viewModel.fetchNextPage()
                            }
                        }
                }
                .listRowBackground(Color.black)
                .listRowSeparator(.hidden, edges: .all)
            }
        }
        .listStyle(.plain)
        .background(Color.black)
        .onAppear {
            viewModel.fetchFirstPage()
        }
        .sheet(isPresented: $isPresented) {
            MovieDetailsView(viewModel: MovieDetailsViewModel(movieId: viewModel.selectedMovieID))
        }
        .alert("Sorry, Something went wrong", isPresented: .constant(viewModel.showingAlert)) {
            Button("OK", role: .cancel) {
                
            }
        }
    }
}

struct MoviesDiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesDiscoveryView(
            viewModel: MoviesDiscoveryViewModel(
                networkService: MockNetworkService(item: MockedModels().moviesDiscoveryResponse)
            )
        ).previewLayout(.sizeThatFits)
    }
}
