//
//  RESTAPIError.swift
//  NYSchoolApp
//
//  Created by Kesh Gurung on 31/03/2023.
//

import Foundation

enum RestApiCallError:Error {
    case invalidRequest
    case apiError
    case dataNotFound
    case responseError
    case parsingError
    case invalidResponse
}


