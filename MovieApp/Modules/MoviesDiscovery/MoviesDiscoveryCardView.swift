//
//  MoviesDiscoveryCardView.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import Foundation
import SwiftUI

struct MoviesDiscoveryCardView: View {
    let movie: Movie
    let size: CGSize

    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack(alignment: .bottom) {
            backdropView
            VStack(alignment: .center, spacing: 8) {
                movieTitle
                movieReleaseDate
            }
        }
        .cornerRadius(16)
        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
        .frame(width: size.width - 20, height: size.height / 4)
        .padding([.top, .bottom], 8)
    }
    
    private var backdropView: some View {
        AsyncImage(
            url: URL(string: "\(Constants.imageBaseURL)\(movie.backdropPath ?? movie.posterPath ?? "")")!,
            content: { image in
                image.resizable()
                    .frame(width: size.width - 30, height: size.height / 3.8)
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
                imagePlaceHolder
            }
        )
    }
    
    private var movieTitle: some View {
        Text(movie.title)
            .font(.title)
            .font(.system(size: 16))
            .foregroundColor(.white)
            .padding(.horizontal)
    }
    
    private var movieReleaseDate: some View {
        Text(movie.releaseDate)
            .font(.system(size: 14))
            .foregroundColor(.gray)
            .padding(.bottom)
    }
    
    private var imagePlaceHolder: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.black, Color.gray]),
            startPoint: .bottom,
            endPoint: .top)
        .overlay(
            ProgressView().foregroundColor(.white)
        )
    }
}

struct MoviesDiscoveryCardView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesDiscoveryCardView(movie: MockedModels().movie,
                                size: .init(width: 400, height: 600))
        .previewLayout(.sizeThatFits)
    }
}
