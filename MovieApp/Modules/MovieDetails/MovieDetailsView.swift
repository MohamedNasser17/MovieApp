//
//  MovieDetailsView.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation
import SwiftUI

struct MovieDetailsView<ViewModel>: View where ViewModel: MovieDetailsViewModelProtocol {
    @ObservedObject var viewModel: ViewModel

    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                VStack {
                    backdropView
                        .frame(width: proxy.size.width,
                               height: proxy.size.height / 2)
                    Spacer()
                }
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(alignment: .center, spacing: 8) {
                        movieTitle
                        movieDuration
                        movieGenres
                        movieOverview
                        Spacer()
                    }
                    .offset(y: proxy.size.height / 3)
                })
            }

        }
        .background(Color.black)
        .ignoresSafeArea(.all, edges: .all)
        .onAppear {
            viewModel.fetchMovieDetails()
        }
        .alert("Sorry, Somthing went wrong", isPresented: .constant(viewModel.showingAlert)) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        }
    }

    private var backdropView: some View {
        AsyncImage(
            url: viewModel.backdropURL,
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black, Color.clear]),
                            startPoint: .bottom,
                            endPoint: .top)
                    )
            },
            placeholder: {
                ProgressView()
            }
        )
    }

    private var movieTitle: some View {
        Text(viewModel.movieDetails?.title ?? "")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal)
    }
    
    private var movieDuration: some View {
        Text(viewModel.movieDuration ?? "")
            .font(.system(size: 15))
            .foregroundColor(.gray)
            .padding(.horizontal)
    }
    
    private var movieGenres: some View {
        HStack(alignment: .center, spacing: 8) {
            ForEach(viewModel.movieDetails?.genres ?? [], id: \.id) { genre in
                Text(genre.name)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                if genre.id != viewModel.movieDetails?.genres.last?.id {
                    Circle()
                        .frame(width: 5, height: 5)
                        .foregroundColor(Color.yellow)
                }
            }
        }
    }
    
    private var movieOverview: some View {
        Text(viewModel.movieDetails?.overview ?? "")
            .foregroundColor(.gray)
            .padding()
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(
            viewModel: MovieDetailsViewModel(
                movieId: 2,
                networkService: MockNetworkService(item: MockedModels().movieDetails)
            )
        ).previewLayout(.sizeThatFits)
    }
}
