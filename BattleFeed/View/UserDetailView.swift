//
//  UserDetailView.swift
//  BattleFeed
//
//  Created by Jitesh Dhumal on 18/10/25.
//

import SwiftUI

// UserDetailView display detail info for a single list t shows user title body and also toggle button for favourite
struct UserDetailView: View {
    let userDetail: UserFeed
    @ObservedObject var viewModel: UserListViewModel
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                userTitleWithHeartSubView
                
                Text(userDetail.body)
                    .font(.subheadline)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding()
            .background(Color.purple.opacity(0.2))
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Sub Views

    private var userTitleWithHeartSubView: some View {
        HStack {
            Text(userDetail.title)
                .font(.largeTitle)
                .foregroundColor(.black)
            
            Spacer()
            
            Button {
                viewModel.toggleFavourite(user: userDetail)
            } label: {
                Image(systemName: viewModel.isFav(user: userDetail) ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.pink)
            }
        }
    }
}

#Preview {
    UserDetailView(userDetail: UserFeed(userID: 0, id: 0, title: "", body: ""), viewModel: UserListViewModel())
}
