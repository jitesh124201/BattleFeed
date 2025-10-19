//
//  TabBarButtonView.swift
//  BattleFeed
//
//  Created by Jitesh Dhumal on 19/10/25.
//

import SwiftUI

// It represent a single button in a custom tabView which handle icon title isSelected and action 
struct TabBarButtonView: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                
                Text(title)
                    .font(.caption)
            }
            .foregroundColor(isSelected ? .black.opacity(0.5) : .white)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.purple : Color.clear)
            .cornerRadius(20)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TabBarButtonView(icon: "", title: "", isSelected: false, action: {})
}
