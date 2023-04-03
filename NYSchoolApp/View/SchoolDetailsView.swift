//
//  SchoolDetailsView.swift
//  NYSchoolApp
//
//  Created by Kesh Gurung on 31/03/2023.
//

import SwiftUI

struct SchoolDetailsView: View {
    let school: School
    
    var body: some View {
        VStack( alignment: .leading){
            schoolInfo.padding()
            Spacer()
        }
    }
    
    var schoolInfo: some View {
        VStack(alignment: .leading){
            Text("Name: \(school.schoolName)")
                .bold()
            if let websiteUrl = URL(string: school.website) {
                Link("Website: \(school.website)", destination: websiteUrl)
            }
            Text("Phone: \(school.phoneNumber)")
                .bold()
            Text("City: \(school.city)")
                .bold()
            Text("Overview: \(school.overviewParagraph)")
                .padding()
        }
    }
}

struct SchoolDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolDetailsView(school: School.mockShcool())
    }
}

