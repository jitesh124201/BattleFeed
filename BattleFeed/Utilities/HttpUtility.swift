//
//  HttpUtility.swift
//  BattleFeed
//
//  Created by Jitesh Dhumal on 18/10/25.
//

import Foundation

// SO here i created a singleton class which is performing a network request and it provides a generic method to fetch data from any url
class HttpUtility {
    static let shared = HttpUtility()
    
    private init() {}
    
    // MARK: - Public Methods
    
    func getData<T: Decodable>(from url: String) async throws -> T {
        // Ensuring the string is valid URL
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data,_) = try await URLSession.shared.data(from: url)
        let decode = try JSONDecoder().decode(T.self, from: data)
        return decode
    }
}
