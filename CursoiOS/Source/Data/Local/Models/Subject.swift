//
//  Subject.swift
//  CursoiOS
//
//  Created by Vbandin on 20/09/2019.
//  Copyright © 2019 ds. All rights reserved.
//

import Foundation

class Subject: CustomStringConvertible {
    var logo: String?
    var name: String?
    var teachers: [Teacher] = []
    var students: [Student] = []
    
    var numTeachers: Int {
        return teachers.count
    }
    var numStudents: Int {
        return students.count
    }
    
    // Use description var of CustomStringConvertible
    // to print this class with custom String format
    var description: String {
        return "Subject data: \(String(describing: name))"
    }
    
    
    convenience init(name: String, teachers: [Teacher] = [], students: [Student] = [], logo: String? = nil) {
        self.init()
        
        self.name = name
        self.teachers = teachers
        self.students = students
        self.logo = logo
    }
}
