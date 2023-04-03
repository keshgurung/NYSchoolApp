//
//  SchoolRepository.swift
//  NYSchoolApp
//
//  Created by Kesh Gurung on 31/03/2023.
//

import Foundation

protocol SchoolDataRepository {
    func fetchSchoolList() async throws -> [School]
}

struct SchoolRepository: JsonDecoder {
    private let serviceManager: RestApiNetworkable
    
    init(serviceManager: RestApiNetworkable) {
        self.serviceManager = serviceManager
    }
}

extension SchoolRepository: SchoolDataRepository {
    func fetchSchoolList() async throws -> [School] {
        do {
            let request = NYSchoolsRequest(path: RestApiEndPoints.nySchoolsPath)
            let data = try await serviceManager.get(request:request)
            let lists = try decode(data:data, to: [School].self)
            return lists
        } catch {
            throw error
        }
    }
}
