//
//  UserFavView.swift
//  BattleFeed
//
//  Created by Jitesh Dhumal on 18/10/25.
//

import SwiftUI

// UserFavView is a section where it will store list of users that have been marked as favorites Users can also toggle the favorite state directly from this view
struct UserFavView: View {
    @ObservedObject var userListViewModel: UserListViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()

                VStack {
                    favUserContent()
                }
                .padding()
            }
            .navigationDestination(for: UserFeed.self) { userDetail in
                UserDetailView(userDetail: userDetail, viewModel: userListViewModel)
            }
        }
    }
    
    // MARK: - Sub Views

    // Decides what to show whether favorite users list exist
    @ViewBuilder
    private func favUserContent() -> some View {
        if userListViewModel.favUserList.isEmpty {
            Text("Please Add Your Fav User on Click of Heart")
                .font(.system(size: 16))
                .foregroundColor(.black)
        } else {
            VStack(alignment: .leading) {
                Text("User Favourites")
                    .bold()
                    .font(.system(size: 23))
                    .foregroundColor(.black)
                
                userFavList
            }
        }
    }
    
    //Scrollable list of fav users
    private var userFavList: some View {
        ScrollView {
            LazyVStack {
                favUserRows()
            }
        }
    }
    
    private func favUserRows() -> some View {
        ForEach(userListViewModel.favUserList, id: \.id) { data in
            NavigationLink(value: data) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("User ID:- \(data.userID)")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        
                        Text(data.title)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    Button {
                        userListViewModel.toggleFavourite(user: data)
                    } label: {
                        Image(systemName: userListViewModel.isFav(user: data) ? "heart.fill" : "heart")
                            .foregroundColor(.pink)
                    }
                }
                .padding()
                .background(Color.purple.opacity(0.2))
                .cornerRadius(12)
                .padding(.vertical,7)
            }
        }
    }
}

#Preview {
    UserFavView(userListViewModel: UserListViewModel())
}
