//
//  SchoolViewModel.swift
//  NYSchoolApp
//
//  Created by Kesh Gurung on 31/03/2023.
//

import Foundation

protocol SchoolViewModelType: ObservableObject {
    func getSchoolList(path: String) async
}

enum ViewStates {
    case loading
    case error
    case loaded
    case emptyView
}

@MainActor
final class SchoolViewModel {
    @Published private(set) var viewState: ViewStates = .loaded
    private(set) var schoolList: [School] = []
    private let repository: SchoolDataRepository
    init(repository: SchoolDataRepository) {
        self.repository = repository
    }
}

extension SchoolViewModel: SchoolViewModelType {
    func getSchoolList(path: String) async {
        viewState = .loading
        do {
            let lists = try await repository.fetchSchoolList()
            schoolList = lists
            if schoolList.isEmpty {
                viewState = .emptyView
            }else {
                viewState = .loaded
            }
        } catch {
            self.viewState = .error
        }
    }
}
