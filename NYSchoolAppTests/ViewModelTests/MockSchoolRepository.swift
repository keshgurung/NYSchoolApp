//
//  MockSchoolRepository.swift
//  NYSchoolAppTests
//
//  Created by Kesh Gurung on 31/03/2023.
//

import Foundation
@testable import NYSchoolApp

class MockSchoolRepository: SchoolDataRepository {

    private var schools: [School] = []
    private var error: RestApiCallError?

    func enqueuResponse(schools: [School]) {
        self.schools = schools
    }
    func enqueuError(error: RestApiCallError) {
        self.error = error
    }
    func fetchSchoolList() async throws -> [NYSchoolApp.School] {
        if error != nil {
            throw error!
        }
        return schools
    }
}
