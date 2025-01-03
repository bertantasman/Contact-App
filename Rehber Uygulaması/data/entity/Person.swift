//
//  Person.swift
//  Rehber Uygulaması
//
//  Created by Bertan Taşman on 4.12.2024.
//

import Foundation

class Person {
    var name: String
    var surname: String
    var phone: String
    var gender: Gender
    
    init(name: String, surname: String, phone: String, gender: Gender) {
        self.name = name
        self.surname = surname
        self.phone = phone
        self.gender = gender
    }
    
}

enum Gender {
    case male
    case female
}
