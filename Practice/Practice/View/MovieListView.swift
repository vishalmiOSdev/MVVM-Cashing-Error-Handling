//
//  ContentView.swift
//  Practice
//
//  Created by Vishal Manhas on 07/10/24.
//
import SwiftUI
struct MovieListView: View {
    @State var searchQuery: String = ""
    @StateObject var viewModel = DataViewModel()

    var filterArray: [Movie] {
        if searchQuery.isEmpty {
            return viewModel.listResponse?.results ?? []
        } else {
            return (viewModel.listResponse?.results ?? []).filter { movie in
                movie.title.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    LoaderView(isAnimating: $viewModel.isLoading)
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorWrapper(title: "No Data", discription: errorMessage)
                } else if filterArray.isEmpty {
                    Text("No Results Found")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(filterArray, id: \.id) { movie in
                        NavigationLink(destination: EmptyView()) {
                            rowView(listResponse: movie)
                        }
                    }
                    .listStyle(.plain)
                }

            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadData()
            }
        }
        .searchable(text: $searchQuery)
    }

    private func loadData() {
       
        viewModel.fetchDataWithCompletionHandler()
    }
}


struct rowView: View {
     var listResponse: Movie
    @State private var cachedImage: UIImage? = nil
    
    var body: some View {
        HStack {
            VStack {
            Image(uiImage:cachedImage ?? UIImage())
                        .resizable()
                        .frame(width: 100, height: 100)
            }

            Text(listResponse.title )
        }
        .task {
           
                cachedImage =  await ImageCache.shared.loadImage(urlString: "https://image.tmdb.org/t/p/w500/\(listResponse.posterPath ?? "")")
            
        }
    }

    
    
    
 
}




#Preview {
    MovieListView()
}

