//
//  UserDataService.swift
//  AboutMeUp (HW 2.6)
//
//  Created by Самир Джафари on 07.10.2023.
//

import Foundation

enum UserDataServiceError: Error {
    case userNotFound(title: String, message: String)
}

fileprivate let users: [User] = [
    User(id: UUID().uuidString, login: "admin", password: "admin"),
    User(id: UUID().uuidString, login: "user", password: "password"),
    User(id: UUID().uuidString, login: "samir", password: "cool_developer")
]

final class UserDataService {
    private init() {}
    
    static func login(for login: String, password: String) throws -> User {
        let user = users.first {
            $0.login == login && $0.password == password
        }
        
        guard let user = user else {
            throw UserDataServiceError.userNotFound(
                title: "Ошибка авторизации", 
                message: "Неверный логин или пароль. Попробуйте снова."
            )
        }
        
        return user
    }
    
    
}
