//
//  LocalDataSource.swift
//  KingBurguer
//
//  Created by angelo on 14/11/25.
//

import Foundation

class LocalDataSource {
    
    static let shared = LocalDataSource()
    
    func insertUserAuth(userAuth: UserAuth) {
        let value = try? PropertyListEncoder().encode(userAuth)
        UserDefaults.standard.set(value, forKey: "user_key")
    }
    
    func getUserAuth() -> UserAuth? {
        if let data = UserDefaults.standard.value(forKey: "user_key") as? Data {
            return try? PropertyListDecoder().decode(UserAuth.self, from: data)
        }
        return nil
    }
}
