//
//  SchoolView.swift
//  NYSchoolApp
//
//  Created by Kesh Gurung on 31/03/2023.
//

import SwiftUI

struct SchoolView: View {
    let school: School
    var body: some View {
        VStack(alignment: .leading){
            Text("Name: \(school.schoolName)")
                .bold()
                .padding(.bottom, 0.5)
                .accessibilityIdentifier("SchoolName")
            Text("Website: \(school.website)")
                .bold()
                .accessibilityIdentifier("SchoolWebsiteAddress")
        }
    }
}

struct SchoolView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolView(school: School(schoolName: "NYC", overviewParagraph: "Info", website: "www.text.com", phoneNumber: "+411900212", city: "NY"))
    }
}
