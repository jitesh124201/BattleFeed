//
//  UserFeed.swift
//  BattleFeed
//
//  Created by Jitesh Dhumal on 18/10/25.
//

import Foundation

struct UserFeed: Codable, Hashable, Identifiable {
    var userID, id: Int
    let title, body: String
    var isFav: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
