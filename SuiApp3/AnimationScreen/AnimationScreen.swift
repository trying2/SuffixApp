//
//  AnimationScreen.swift
//  SuiApp3
//
//  Created by Александр Вяткин on 22.09.2021.
//

import SwiftUI
import Networking

struct AnimationScreen: View {
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
                    AnimationListCell(movie: movie)
                        .environmentObject(movieViewModel)
                }
            } header: {
                listHeader
            }
        }.listStyle(GroupedListStyle())
    }
    var body: some View {
        TabView {
            weekMovieTrendsViews
                .tabItem {
                    Text("Favorites")
                    Image(systemName: "star.fill")
                
                }
        }
        
    }
}

struct AnimationListCell: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    @State var startAnimation: Bool = false
    
    var movie: Movie
    
    var buttonLabel: some View {
        VStack {
            HStack {
                Text("\(movie.title)")
                Spacer()
            }.onAppear {
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
        GeometryReader { geom in
            ZStack {
                buttonLabel
                VStack {
                    HStack {
                        if startAnimation {
                            Spacer()
                        }
                        Text("\(movie.title)")
                        Spacer()
                            
                    }
                    
                    Divider()
                        .opacity(self.startAnimation ? 1 : 0)
                }
                .background(Color.white)
                .scaleEffect(self.startAnimation ? 0.01 : 1)
                .offset(y: self.startAnimation ? UIScreen.main.bounds.height-geom.frame(in: .global).maxY-60 : 0)
                .animation(.easeInOut(duration: 0.6))
                .opacity(self.startAnimation ? 1 : 0)
            }.onTapGesture {
                // print((UIScreen.main.bounds.height-geom.frame(in: .global).maxY))
                self.startAnimation.toggle()
            }
        }
        
    }
}

struct AnimationScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnimationScreen()
    }
}
