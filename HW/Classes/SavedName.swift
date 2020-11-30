//
//  SavedName.swift
//  HW
//
//  Created by Artem Tsolov on 27.10.2020.
//

import Foundation

class SavedName {
    static let shared = SavedName()
    
    private let kUserNameKey = "SavedName.kUserNameKey"
    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey)}
        get { return UserDefaults.standard.string(forKey: kUserNameKey)}
        
    }
    
    private let kUserSurnameKey = "SavedName.kUserSurnameKey"
    var userSurname: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserSurnameKey)}
        get { return UserDefaults.standard.string(forKey: kUserSurnameKey)}
        
    }
}
