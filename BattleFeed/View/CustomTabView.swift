//
//  CustomTabView.swift
//  BattleFeed
//
//  Created by Jitesh Dhumal on 19/10/25.
//

import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab: Int = 0
    @StateObject var userListViewModel: UserListViewModel = UserListViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            switchTabs
            
            tabBarButtonView
        }
    }
    
    // MARK: - Sub Views

    // switch tab subView default user will land on UserListView
    private var switchTabs: some View {
        Group {
            switch selectedTab {
            case 0:
                UserListView(userListViewModel: userListViewModel)
            case 1:
                UserFavView(userListViewModel: userListViewModel)
            default:
                UserListView(userListViewModel: userListViewModel)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // TabBar Custom Button sub view
    private var tabBarButtonView: some View {
        HStack {
            TabBarButtonView(icon: "list.bullet", title: "Feed", isSelected: selectedTab == 0) {
                withAnimation(.easeInOut) {
                    selectedTab = 0
                }
            }
            
            Spacer()
            
            TabBarButtonView(icon: "heart.fill", title: "Favorites", isSelected: selectedTab == 1) {
                withAnimation(.easeInOut) {
                    selectedTab = 1
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 25)
        .background(Color.purple)
        .cornerRadius(30)
        .padding(.horizontal, 30)
        .shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    CustomTabView()
}
