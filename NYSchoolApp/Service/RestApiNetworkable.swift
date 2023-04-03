//
//  RESTAPINetworkable.swift
//  NYSchoolApp
//
//  Created by Kesh Gurung on 31/03/2023.
//

import Foundation

protocol RestApiNetworkable {
    func get(request: Requestable) async throws -> Data
}

