//
//  User.swift
//  AboutMeUp (HW 2.6)
//
//  Created by Самир Джафари on 07.10.2023.
//

import Foundation
import UIKit

struct User {
    var id: String
    var login: String
    var password: String
    var info: Info
    var hobbies: [String]
    
    struct Info {
        var name: String
        var surname: String
        var age: Int
        var post: String
        var image: UIImage
    }
    
    // не успевал сделать "по-красоте" (задание в целом) не было времени совсем...
    // я потом улучшу проект и сделаю конфетку и по логике может что додумаю, а пока что есть - то есть :(
}
