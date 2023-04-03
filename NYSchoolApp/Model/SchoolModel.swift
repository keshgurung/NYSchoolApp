//
//  SchoolModel.swift
//  NYSchoolApp
//
//  Created by Kesh Gurung on 31/03/2023.
//

import Foundation

struct School: Decodable, Identifiable {
    let id = UUID()
    let schoolName: String
    let overviewParagraph: String
    let website: String
    let phoneNumber: String
    let city: String
}

extension School {
    static func mockShcool() -> School {
        return School(schoolName: "Clinton School Writers & Artists, M.S. 260", overviewParagraph: "Info", website: "www.text.com", phoneNumber: "+411900212", city: "NY")
    }
}
