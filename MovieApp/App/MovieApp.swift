//
//  MovieApp.swift
//  MovieApp
//
//  Created by Mohamed Abdelhameed on 26/7/23.
//

import SwiftUI

@main
struct MovieApp: App {
    var body: some Scene {
        WindowGroup {
            MoviesDiscoveryView(viewModel: MoviesDiscoveryViewModel())
        }
    }
}
