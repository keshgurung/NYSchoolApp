//
//  MockRESTAPINetworking.swift
//  NYSchoolAppTests
//
//  Created by Kesh Gurung on 31/03/2023.
//

import Foundation
@testable import NYSchoolApp

class MockRestApiNetworking: RestApiNetworking {
    var mockData: Data!
    var mockResponse: URLResponse!
    var error: Error?

    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        if error != nil {
            throw error!
        }
        return (mockData, mockResponse)
    }
}
