//
//  UserDataService.swift
//  AboutMeUp (HW 2.6)
//
//  Created by Самир Джафари on 07.10.2023.
//

import Foundation
import UIKit

enum UserDataServiceError: Error {
    case userNotFound(title: String, message: String)
}

fileprivate let users: [User] = [
    User(
        id: UUID().uuidString,
        login: "samir",
        password: "samir",
        info: User.Info(
            name: "Самир",
            surname: "Джафари",
            age: 22,
            post: "Разработчик",
            image: .samir
        ),
        hobbies: ["Путешествовать",
                  "Гладить котеек и собачек",
                  "Ездить в поездах",
                  "Смотреть киношки",
                  "Готовить",
                  "Писать код",
                  "Слушать музыку"]
    )
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
