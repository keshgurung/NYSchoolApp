//
//  SchoolRepositoryTests.swift
//  NYSchoolAppTests
//
//  Created by Kesh Gurung on 31/03/2023.
//

import XCTest
@testable import NYSchoolApp

final class SchoolRepositoryTests: XCTestCase {
    
    var mockRestAPIManager: MockRestAPIManager!
    var schoolRepository: SchoolRepository!
    
    @MainActor override func setUp() {
        mockRestAPIManager = MockRestAPIManager()
        schoolRepository = SchoolRepository(serviceManager: mockRestAPIManager)
    }
    
    override func tearDown() {
        schoolRepository = nil
        mockRestAPIManager = nil
    }
    
    // when apiManager return success data
    func testWhenGeSchoolListSuccess() async {
        mockRestAPIManager.path = "SchoolAPIResponseData"
        let lists = try! await schoolRepository.fetchSchoolList()
        XCTAssertNotNil(lists)
        XCTAssertEqual(lists.count, 1)
        XCTAssertEqual(lists.first?.schoolName, "Clinton School Writers & Artists, M.S. 260")
    }
    
    // when fails, school list data is not nil but parsing fails due to key mismatching
    func testWhenGeSchoolListParsingFails() async throws {
        // GIVEN
        mockRestAPIManager.path = "SchoolAPIResponseDataKeyMisMatch"
        do {
           _ = try await schoolRepository.fetchSchoolList()
        } catch {
            XCTAssertEqual(error as! RestApiCallError, RestApiCallError.parsingError)
        }
    }
    
    // when fails, networkMangers throws error due to any connection issue.
  func testWhenGeSchoolListWheNetworkMangerThrowsErrorDueToConnectionIssue() async throws {
        // GIVEN
        mockRestAPIManager.path = ""
        do {
            _ = try await schoolRepository.fetchSchoolList()
        } catch {
            XCTAssertEqual(error as! RestApiCallError, RestApiCallError.dataNotFound)
        }
    }
}

