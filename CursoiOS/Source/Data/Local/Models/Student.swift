//
//  Student.swift
//  CursoiOS
//
//  Created by Vbandin on 20/09/2019.
//  Copyright © 2019 ds. All rights reserved.
//

import Foundation

class Student: Hashable, CustomStringConvertible {
    // Equatable protocol implementation
    static func == (lhs: Student, rhs: Student) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    // Hashable protocol implementation
    func hash(into hasher: inout Hasher) {
        return hasher.combine(ObjectIdentifier(self))
    }
    
    // MARK: Properties
    //Properties whith optional '?' value can be nil
    var avatar: String?
    var name: String?
    var email: String?
    var birthdate: Date?
    
    // Use description var of CustomStringConvertible
    // to print this class with custom String format
    var description: String {
        return "Student data: \(String(describing: name)) \(String(describing: email))"
    }

    // Custom init (Constructor) class with default values
    convenience init(name: String, email: String? = nil, birthdate: Date? = nil, avatar: String? = nil) {
        self.init()
        
        // Always init all properties
        self.name = name
        self.email = email
        self.birthdate = birthdate
        self.avatar = avatar
    }
}
