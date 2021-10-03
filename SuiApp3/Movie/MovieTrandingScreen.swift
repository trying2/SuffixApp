//
//  MovieTrandingScreen.swift
//  MovieTrandingScreen
//
//  Created by Александр Вяткин on 18.09.2021.
//

import SwiftUI
import AppUI
import Networking

struct MovieTrandingScreen: View {
    @StateObject var movieViewModel: MovieViewModel = .init()
    
    var listHeader: some View {
        HStack {
            Text("\(movieViewModel.movieList.count)/\(movieViewModel.totalResults) (\(movieViewModel.pageLoadCount))")
        }
    }
    
    var weekMovieTrendsViews: some View {
        List() {
            Section {
                ForEach(self.movieViewModel.movieList) { movie in
                    MovieListCell(movie: movie)
                        .environmentObject(movieViewModel)
                }
            } header: {
                listHeader
            }
        }.listStyle(GroupedListStyle())
    }
    var body: some View {
        weekMovieTrendsViews
    }
}

struct MovieListCell: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    
    var movie: Movie
    
    var buttonLabel: some View {
        VStack {
            Text("\(movie.title)")
                .onAppear {
                    if movieViewModel.movieList.isLast(movie) {
                        self.movieViewModel.fetchTrendingMoviesPage()
                    }
                }
            if movieViewModel.movieList.isLast(movie) && movieViewModel.isPageLoading {
                VStack(alignment: .center) {
                    Divider()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
        }
        
    }
    
    var body: some View {
        NavPushButton(destination: MovieDetailScreen(movie: movie)) {
            buttonLabel
        }
    }
}

struct MovieTrandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        MovieTrandingScreen()
    }
}
