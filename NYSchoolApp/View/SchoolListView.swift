//
//  SchoolListView.swift
//  NYSchoolApp
//
//  Created by Kesh Gurung on 31/03/2023.
//

import SwiftUI

struct SchoolListView: View {
    @StateObject var viewModel: SchoolViewModel
    @State private var isErrorOccured = true
    
    var body: some View {
        NavigationStack{
            VStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                case .loaded:
                    showSchoolListView()
                case .error:
                    showErrorView()
                case .emptyView:
                    EmptyView()
                }
            }
            .navigationTitle(Text(LocalizedStringKey("SchoolLists")))
        }.task {
            await viewModel.getSchoolList(path: RestApiEndPoints.nySchoolsPath)
        }
    }
    @ViewBuilder
    func showSchoolListView() -> some View {
        List(viewModel.schoolList){ school in
            NavigationLink {
                SchoolDetailsView(school: school)
            }label: {
                SchoolView(school: school)
            }
        }
    }
    @ViewBuilder
    func showErrorView() -> some View {
        ProgressView().alert(isPresented: $isErrorOccured){
            Alert(title: Text("Error Occured"),message: Text("Something went wrong"),
                  dismissButton: .default(Text("Ok")))
        }
    }
}

struct SchoolListView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListView(viewModel: SchoolViewModel(repository: SchoolRepository(serviceManager: RestApiManager())))
    }
}
