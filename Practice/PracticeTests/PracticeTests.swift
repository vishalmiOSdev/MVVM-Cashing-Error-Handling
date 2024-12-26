//
//  PracticeTests.swift
//  PracticeTests
//
//  Created by Vishal Manhas on 03/12/24.
//

import XCTest
//@testable import Practice

final class PracticeTests: XCTestCase {
  
//        var viewModel: DataViewModel!
//        var mockAPIService: MockAPIService!

        override func setUp() {
            super.setUp()
            // Initialize the mock service and inject into the view model
//            mockAPIService = MockAPIService()
//            
            DispatchQueue.main.async {
//                self.viewModel = DataViewModel(apiService: self.mockAPIService)
            }
           
        
        }

        override func tearDown() {
//            viewModel = nil
//            mockAPIService = nil
            super.tearDown()
        }

        // Test case for successful API call
        func testFetchDataSuccess() async {
            // Make sure mockAPIService returns mock data
//            mockAPIService.shouldReturnError = false
            
            // Call the fetchData method
//            await viewModel.fetchData()
//            
//            // Check the results
//            DispatchQueue.main.async {
//                XCTAssertNotNil(self.viewModel.listResponse)
//                XCTAssertEqual(self.viewModel.listResponse?.results.count, 2)
//                XCTAssertEqual(self.viewModel.listResponse?.results[0].title, "Movie 1")
//            }
//        
        }

        // Test case for error during API call
        func testFetchDataError() async {
            // Simulate an error (e.g., bad URL error)
//            mockAPIService.shouldReturnError = true
//            mockAPIService.errorType = .badUrl
//            
//            // Call the fetchData method
//            await viewModel.fetchData()
//            
//           
//            DispatchQueue.main.async {
//                XCTAssertEqual(self.viewModel.errorMessage, NetworkError.badUrl.errorValue)
//            }
        }
    }




//class MockAPIService: APIServiceProtocol {
//    var shouldReturnError = false
//    var errorType: NetworkError = .unknownError
//
//    func doRequest<T: Codable>(url: URL?) async throws -> T {
//        if shouldReturnError {
//            throw errorType
//        }
//
//        guard let path = Bundle(for: type(of: self)).path(forResource: "MockMovieResponse", ofType: "json"),
//              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
//            throw NetworkError.badResponse
//        }
//
//        do {
//            let decodedData = try JSONDecoder().decode(T.self, from: data)
//            return decodedData
//        } catch {
//            throw NetworkError.decodingError
//        }
//    }
//}
