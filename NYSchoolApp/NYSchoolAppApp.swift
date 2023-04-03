//
//  NYSchoolAppApp.swift
//  NYSchoolApp
//
//  Created by Kesh Gurung on 31/03/2023.
//

import SwiftUI

@main
struct NYSchoolAppApp: App {
    var body: some Scene {
        WindowGroup {
            SchoolListView(viewModel: SchoolViewModel(repository: SchoolRepository(serviceManager: RestApiManager())))
        }
    }
}
