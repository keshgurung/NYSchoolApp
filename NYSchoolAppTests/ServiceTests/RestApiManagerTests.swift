//
//  RESTAPIManagerTests.swift
//  NYSchoolAppTests
//
//  Created by Kesh Gurung on 31/03/2023.
//

import XCTest
@testable import NYSchoolApp

final class RestApiManagerTests: XCTestCase {
    
    var mockRestAPIManager: MockRestApiNetworking!
    var serviceManager: RestApiManager!
    
    @MainActor override func setUp() {
        mockRestAPIManager = MockRestApiNetworking()
        serviceManager = RestApiManager(urlSession: mockRestAPIManager)
    }
    
    override func tearDown() {
        mockRestAPIManager = nil
        serviceManager = nil
    }
    //when API is successful, get function will return expected data,
    
    func testGetSchoolListWhenResponseIs_200() async {
        // reading local json file data
      
         let data = "response".data(using: .utf8)
        mockRestAPIManager.mockData = data
        mockRestAPIManager.mockResponse = HTTPURLResponse(url:URL(string: "test")!, statusCode: 200, httpVersion:nil, headerFields:nil)
        let actualData = try! await serviceManager.get(request: NYSchoolsRequest(path:"test"))
        XCTAssertEqual(actualData, data)
    }
    
    //when API is fails with 404 response code
    
    func testGetSchoolListWhenResponseIs404() async {
        // reading local json file data
      
         let data = "response".data(using: .utf8)
        mockRestAPIManager.mockData = data
        mockRestAPIManager.mockResponse = HTTPURLResponse(url:URL(string: "test")!, statusCode: 404, httpVersion:nil, headerFields:nil)
        
        do {
            _ = try await serviceManager.get(request: NYSchoolsRequest(path:"test"))
        } catch {
            XCTAssertEqual(error as! RestApiCallError, RestApiCallError.invalidResponse)
        }
        
    }
    
    //when API is fails with response code other than 200 to 299
    
    func testGetSchoolListWhenResponseIs502() async {
        // reading local json file data
      
         let data = "response".data(using: .utf8)
        mockRestAPIManager.mockData = data
        mockRestAPIManager.mockResponse = HTTPURLResponse(url:URL(string: "test")!, statusCode: 502, httpVersion:nil, headerFields:nil)
        
        do {
            _ = try await serviceManager.get(request: NYSchoolsRequest(path:"test"))
        } catch {
            XCTAssertEqual(error as! RestApiCallError, RestApiCallError.invalidResponse)
        }
        
    }
    
    //when API is fails with request invalid

    func testGetSchoolListWhenRequestIsNotValid() async {
        do {
            _ = try await serviceManager.get(request: NYSchoolsRequest(path:""))
        } catch {
            XCTAssertEqual(error as! RestApiCallError, RestApiCallError.invalidRequest)
        }
    }
}

