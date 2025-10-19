//
//  UserListView.swift
//  BattleFeed
//
//  Created by Jitesh Dhumal on 18/10/25.
//

import SwiftUI

// UserListView display list of user fetch from api and we can also filter it will title it support searching pull to refresh loading state and error handling(in case my api will get failed)
struct UserListView: View {
    @ObservedObject var userListViewModel: UserListViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack{
                    HeaderSubView
                    
                    textfieldSubView
                    
                    casesSubView()
                    
                }
                .padding(.horizontal)
                
            }
            .navigationDestination(for: UserFeed.self) { userDetail in
                UserDetailView(userDetail: userDetail, viewModel: userListViewModel)
            }
            .onChange(of: userListViewModel.searchString) { oldValue, newValue in
                print("change value from -\(oldValue) - \(newValue)")
                Task {
                    await userListViewModel.fetchUser()
                }
            }
            .task {
                await userListViewModel.fetchUser()
            }
        }
    }
    
    // MARK: - Sub Views
    
    // Its a textfield view where user can search and filter out rows with title
    private var textfieldSubView: some View {
        HStack {
            TextField("Search", text: $userListViewModel.searchString)
                .font(.system(size: 16).bold())
                .contentShape(Rectangle())
                
            if userListViewModel.searchString.isEmpty {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
            } else {
                Button {
                    userListViewModel.searchString = ""
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.all, 15)
        .background(Color.purple)
        .cornerRadius(12)
    }
    
    // Header Subview
    private var HeaderSubView: some View {
        HStack {
            Text("User List")
                .bold()
                .font(.system(size: 23))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            
            Spacer()

        }
        .padding(.top)
    }
    
    // list of user which we get from api
    private var listOfUser: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 10) {
                eachListOfUser()
            }
        }
        .refreshable {
            await userListViewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    private func eachListOfUser() -> some View {
        ForEach(userListViewModel.filterUserList, id: \.id) { data in
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
    
    // CasesSubView shows which content to display based on loading error or normal state
    @ViewBuilder
    private func casesSubView() -> some View {
        if userListViewModel.isLoading {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                .scaleEffect(1.5)
                .padding(.top, 10)
            Spacer()
        } else if let error = userListViewModel.errorMessage {
            Spacer()
            VStack(spacing: 12) {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    Task {
                        await userListViewModel.fetchUser()
                    }
                }) {
                    Text("Retry")
                        .bold()
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
            Spacer()

        } else {
            listOfUser
        }
    }
}

#Preview {
    UserListView(userListViewModel: UserListViewModel())
}
