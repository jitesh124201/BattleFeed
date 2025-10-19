# BattleFeed

## Overview
**BattleFeed** is a simple iOS app that fetches user data from a REST API and displays it in a list. Users can search through the list, mark favorites, and view detailed information for each user. The app demonstrates modern SwiftUI practices with a clean MVVM architecture.

---

## Features
- Fetches user data from `https://jsonplaceholder.typicode.com/posts`.
- Search functionality to filter users by title.
- Favorite users feature with a heart toggle.
- Detail view for each user showing  Title, and body and a heart Toggle button.
- Loading indicator while fetching data.
- Error handling with retry button.
- Pull-to-refresh support.
- Custom TabView for switching between Feed and Favorites.

## Setup Instructions
- Clone the repository: git clone https://github.com/<your-username>/BattleFeed.git
- Open the project in Xcode: Navigate to the cloned folder Double-click BattleFeed.xcodeproj or open Xcode → File → Open → select BattleFeed.xcodeproj.
- Check your Xcode version: Make sure you are using Xcode 15 or later The project targets iOS 17.6+
- Build and run the app: Select a simulator (e.g., iPhone 15) or a physical iOS device and press run

## Brief explanation of architecture (MVVM)
- BattleFeed uses the MVVM (Model-View-ViewModel) pattern to separate concerns and make the code clean and maintainable
- Model: UserFeed represents user data from the API.
- View: SwiftUI views (UserListView, UserFavView, UserDetailView) display data and handle user interactions.
- ViewModel: UserListViewModel manages API calls, search, favorites, loading, and error states.

## Improvements
- We can add dark mode for better user experience.
- Save favorite users locally using CoreData so favorites remain after app restart
- Add unit tests for ViewModel and network layer
- Enhance UI with animations, custom icons, and images
- We can allow users to sort by ID or title and can add advance filter 
