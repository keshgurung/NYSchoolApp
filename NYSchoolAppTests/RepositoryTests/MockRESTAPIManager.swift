//
//  MockRESTAPIManager.swift
//  NYSchoolAppTests
//
//  Created by Kesh Gurung on 31/03/2023.
//

import Foundation
@testable import NYSchoolApp

class MockRestAPIManager: RestApiNetworkable {
    var path: String = ""
    func get(request: NYSchoolApp.Requestable) async throws -> Data {
        do {
            let bundle = Bundle(for: MockRestAPIManager.self)
            guard !path.isEmpty, let resourcePath = bundle.url(forResource: path, withExtension: "json") else
            {
                throw RestApiCallError.apiError
            }
            let data = try Data(contentsOf: resourcePath)
            return data
        } catch {
            throw RestApiCallError.dataNotFound
        }
    }
}
