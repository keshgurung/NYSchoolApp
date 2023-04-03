//
//  SchoolViewModelTest.swift
//  NYSchoolAppTests
//
//  Created by Kesh Gurung on 31/03/2023.
//

import XCTest
@testable import NYSchoolApp

final class SchoolViewModelTest: XCTestCase {
    
    var mockSchoolRepository: MockSchoolRepository!
    var shoolViewModel: SchoolViewModel!
    
    @MainActor override func setUp() {
        mockSchoolRepository = MockSchoolRepository()
        shoolViewModel =  SchoolViewModel(repository: mockSchoolRepository)
    }
    
    override func tearDown() {
        mockSchoolRepository = nil
        shoolViewModel = nil
    }
    
    //when school list is not empty
    func testGetSchoolWhenListIsNotEmpty() async {
        
        // Given
        mockSchoolRepository.enqueuResponse(schools: [School.mockShcool()])
        
        // When
        await shoolViewModel.getSchoolList(path: "SchoolAPIResponseData")
        
        // Then
        let empList = await shoolViewModel.schoolList
        XCTAssertEqual(empList.count, 1)
        XCTAssertEqual(empList.first?.schoolName, "Clinton School Writers & Artists, M.S. 260")

        let viewState = await shoolViewModel.viewState
        XCTAssertEqual(viewState, .loaded)
    }
    
    
    //when school list is empty
    func testGetSchoolWhenListIsEmpty() async {
        
        // Given
        mockSchoolRepository.enqueuResponse(schools: [])
        
        // When
        await shoolViewModel.getSchoolList(path: "SchoolAPIResponseData")
        
        // Then

        let empList = await shoolViewModel.schoolList
        XCTAssertEqual(empList.count, 0)
        let viewState = await shoolViewModel.viewState
        XCTAssertEqual(viewState, .emptyView)
    }
    
    
    //when repository throws error for getSchools
    func testGetSchoolWhenRepositoryThrowsError() async {
        
        // Given
        mockSchoolRepository.enqueuError(error: RestApiCallError.apiError)
        
        // When
        await shoolViewModel.getSchoolList(path: "SchoolAPIResponseData")
        
        // Then
        let empList = await shoolViewModel.schoolList
        XCTAssertEqual(empList.count, 0)
        let viewState = await shoolViewModel.viewState
        XCTAssertEqual(viewState, .error)
    }
}

