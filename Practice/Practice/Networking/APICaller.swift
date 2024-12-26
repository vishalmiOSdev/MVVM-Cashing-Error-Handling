//
//  APICaller.swift
//  Practice
//
//  Created by Vishal Manhas on 27/11/24.
//

import Foundation
enum NetworkError: Error {
    case badUrl
    case decodingError
    case badResponse
    case unknownError
    
    var errorValue:String{
        switch self{
        case .badUrl:
             "URL Does not match"
        case .decodingError:
             "Type mismatch error ,Internal Error "
        case .badResponse:
             "Server Error"
        case .unknownError:
             "Unknown Error"
        }
    }
}

protocol APIServiceProtocol{
    func doRequest<T: Codable>(url: URL?) async throws -> T
}

class APICaller:APIServiceProtocol {
    
    func doRequest<T: Codable>(url: URL?) async throws -> T {
        guard let url = url else {
            throw NetworkError.badUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
     

        print("Request URL: \(urlRequest.url?.absoluteString ?? "No URL")")
      
        print(urlRequest)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            print("Raw Data: \(String(data: data, encoding: .utf8) ?? "No data received")")
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                throw NetworkError.badResponse
            }
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch let decodingError as DecodingError {
            print("Decoding Error: \(decodingError)")
            throw NetworkError.decodingError
        } catch {
            print("Unexpected Error: \(error.localizedDescription)")
            throw NetworkError.unknownError
        }


    }
    
    
    
    func doRequestWithCompletionHandler<T: Codable>(url: URL?, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = url else {
            return completionHandler(.failure(.badUrl))
        }
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
       
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
           
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return completionHandler(.failure(.badResponse))
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                print("HTTP Error: \(httpResponse.statusCode)")
                return completionHandler(.failure(.badResponse))
            }
            
            guard let dataFound = data else {
                print("No data received.")
                return completionHandler(.failure(.badResponse))
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: dataFound)
                completionHandler(.success(decodedData))
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completionHandler(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    
}
