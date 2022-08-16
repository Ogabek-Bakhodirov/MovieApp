//
//  TokenModel.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 16/08/22.
//

import Foundation

struct TokenModel: Codable{
    let success: Bool
    let expiresAt: String
    let requestToken: String
    
    private enum CodingKeys: String, CodingKey{        
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
