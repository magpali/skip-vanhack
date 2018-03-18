//
//  AuthHelper.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit

fileprivate let tokenKey = "authToken"

class AuthHelper {
    
    static func saveToken(token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    static func logOut() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
}
