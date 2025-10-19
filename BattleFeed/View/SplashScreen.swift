//
//  SplashScreen.swift
//  BattleFeed
//
//  Created by Jitesh Dhumal on 19/10/25.
//

import SwiftUI

// splashscreen where user open up app it will first see splashscreen for 3 sec and then i will move to CustomTabView
struct SplashScreen: View {
    @State private var isActive = false
    @State private var animate = false

    var body: some View {
        progressView()
    }
    
    // for complex if else logic instead of writing directly into a view its a good practice to use a Viewbuilder and write a func which return a view which keep body clean and readable
    @ViewBuilder
    private func progressView() -> some View {
        if isActive {
            CustomTabView()
        } else {
            VStack {
                Image("newBattleFeed")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                    .scaleEffect(1.5)
                    .padding(.top, 10)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
