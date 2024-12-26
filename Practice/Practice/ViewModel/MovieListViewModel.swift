//
//  ViewModel.swift
//  Practice
//
//  Created by Vishal Manhas on 27/11/24.
//

import Foundation
import SwiftUI
import Observation

@MainActor
class DataViewModel:ObservableObject{
    
    @Published var listResponse:MovieResponse?
    @Published var isLoading:Bool = true
    @Published var errorMessage:String? = nil
    
      private let apiService: APIServiceProtocol
       
    
       init(apiService: APIServiceProtocol = APICaller()) {
           self.apiService = apiService
       }
    
    func fetchData() async {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}

        
        isLoading = true
        errorMessage = nil
        do {
            let data:MovieResponse = try await apiService.doRequest(url: url)
            listResponse = data
            isLoading = false
        } catch let error as NetworkError {
            errorMessage = error.errorValue
            isLoading = false
        } catch {
            errorMessage = "An unexpected error occurred."
            isLoading = false
        }
    }
    
    
    func fetchDataWithCompletionHandler() {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else { 
            print("Invalid URL")
            return }
        isLoading = true
        errorMessage = nil
        
        APICaller().doRequestWithCompletionHandler(url: url) {   (result: Result<MovieResponse, NetworkError>) in
           
            switch result {
           
                case .success(let response):
                    
                    print(" Success the func")
              
                DispatchQueue.main.async {
                    self.listResponse = response
                
                    self.isLoading = false
                    print(response)
                 
                }
                case .failure(let error):
                self.isLoading = false
                    self.errorMessage = error.errorValue
                    print("Error: \(error)")
                    
                }
            
        }
    }    
}


import Combine

@propertyWrapper
struct MyPublished<Value> {
    private var value: Value
    private var publisher: ObservableObjectPublisher
    
    init(wrappedValue: Value) {
        self.value = wrappedValue
        self.publisher = ObservableObjectPublisher()
    }

    // Access the wrapped value
    var wrappedValue: Value {
        get { value }
        set {
            value = newValue
            publisher.send() // Notify observers
        }
    }

    // Expose the publisher through projected value
    var projectedValue: ObservableObjectPublisher {
        publisher
    }
}
