//
//  AnimationViewModel.swift
//  SuiApp3
//
//  Created by Александр Вяткин on 22.09.2021.
//

import Foundation

final class AnimationViewModel: ObservableObject {
    @Injected var movieApiService: MoviesAPI?
    @Published var movieList: [Movie] = .init()
    
    @Published var isPageLoading: Bool = false
    
    @Published var page: Int = 0
    @Published var totalResults: Int = 999
    @Published var pageLoadCount: Int = 0
    
    let apiKey = "0dc34a2f3a360bd0e26e68231be276ef"
    
    init() {
        self.fetchTrendingMoviesPage()
    }
    
    func fetchTrendingMoviesPage() {
        guard isPageLoading == false, movieList.count < totalResults else {
            return
        }
        isPageLoading = true
        page += 1
        
        movieApiService?.getTrendingMovie(apiKey: apiKey, page: page) { data, error in
            self.isPageLoading = false
            
            if error != nil {
                print(error?.localizedDescription)
            }
            
            guard let movieData = data else {
                return
            }
            self.pageLoadCount += 1
            
            self.totalResults = movieData.totalResults
            
            self.movieList.append(contentsOf: movieData.results)
        }
    }
}
