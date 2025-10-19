//
//  UserListViewModel.swift
//  BattleFeed
//
//  Created by Jitesh Dhumal on 18/10/25.
//

import Foundation

//UserListViewModel is the main viewModel where we anaging rows in the app it handle fetching data from the api and filter it out based on search manage fav user and tracks loading error states
@MainActor
class UserListViewModel: ObservableObject {
    @Published var usersList: [UserFeed] = []
    @Published var filterUserList: [UserFeed] = []
    @Published var searchString: String = ""
    @Published var favUserList: [UserFeed] = []
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func fetchUser() async {
        isLoading = true
        errorMessage = nil
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            let data: [UserFeed] = try await HttpUtility.shared.getData(from: "https://jsonplaceholder.typicode.com/posts")
            
                usersList = data
                filterUserList = searchString.isEmpty ? usersList : usersList.filter {  $0.title.lowercased().contains(searchString.lowercased()) }
            
            print("uerlist -> \(usersList)")
            print("filter user list -> \(filterUserList)")
        } catch {
            errorMessage = "Failed to fetch your request!!!"
        }
        isLoading = false
    }
    
    // MARK: - Favorites Handling
    
    // It checks if user is cuurently in fav list
    func isFav(user: UserFeed) -> Bool {
        favUserList.contains(where: { $0.id == user.id })
    }
    
    // toggle the fav state of a row
    func toggleFavourite(user: UserFeed) {
        if let index = favUserList.firstIndex(where: { $0.id == user.id }) {
            favUserList.remove(at: index)
        } else {
            favUserList.append(user)
        }
    }
}
