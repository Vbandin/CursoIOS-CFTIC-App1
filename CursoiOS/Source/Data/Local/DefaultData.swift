//
//  DefaultData.swift
//  CursoiOS
//
//  Created by Vbandin on 23/09/2019.
//  Copyright © 2019 ds. All rights reserved.
//

import Foundation

// MARK: -  Create list of Students

// With Calendar and DateComponents class can create a new Date
// Calendar.current return actual Calendar 'Gregorian'
var defaultStudents = [Student(name: "Óliver",
                               email: "oliver@gmail.com",
                               birthdate: Calendar.current.date(from: DateComponents(year: 2019,
                                                                                     month: 5)),
                               avatar:"img_student_1"),
                       Student(name: "Sara",
                               email: "sara@gmail.com",
                               birthdate: Calendar.current.date(from: DateComponents(year: 1984,
                                                                                     month: 9)),
                               avatar:"img_student_3"),
                       Student(name: "David",
                               email: "david@gmail.com",
                               birthdate: Calendar.current.date(from: DateComponents(year: 1985,
                                                                                     month: 4)),
                               avatar:"img_student_2"),
                       Student(name: "Ángel",
                               email: "angel@gmail.com",
                               birthdate: Calendar.current.date(from: DateComponents(year: 2013,
                                                                                     month: 9)),
                               avatar:"img_student_6"),
                       Student(name: "María",
                               email: "maria@gmail.com",
                               birthdate: Calendar.current.date(from: DateComponents(year: 1956,
                                                                                     month: 4)),
                               avatar:"img_student_5"),
                       Student(name: "Eduardo",
                               email: "eduardo@gmail.com",
                               birthdate: Calendar.current.date(from: DateComponents(year: 1956,
                                                                                     month: 12)),
                               avatar:"img_student_4"),
                       Student(name: "Miguel",
                               email: "miguel@gmail.com",
                               birthdate: Calendar.current.date(from: DateComponents(year: 1983,
                                                                                     month: 6)),
                               avatar:"img_student_7")]
// MARK: -  Create list of Teachers

// With .extern or .intern we represent the Enum value for this properties.
var defaultTeachers = [Teacher(name: "Juan",
                               email: "juan@gmail.com",
                               type: .intern,
                               avatar:"img_teacher_1"),
                       Teacher(name: "Lucía",
                               email: "lucia@gmail.com",
                               type: .extern,
                               avatar:"img_teacher_3"),
                       Teacher(name: "Paula",
                               email: "paula@gmail.com",
                               type: .extern,
                               avatar:"img_teacher_2"),
                       Teacher(name: "Javier",
                               email: "javier@gmail.com",
                               type: .intern,
                               avatar:"img_teacher_5"),
                       Teacher(name: "Marta",
                               email: "marta@gmail.com",
                               type: .intern,
                               avatar:"img_teacher_4")]

// MARK: - Create list of Subjects
// Use a list.filter for get different values for each subject
var defaultSubjects = [Subject(name: "Android",
                               teachers: defaultTeachers.filter{$0.name?.contains("u") ?? false},
                               students: defaultStudents.filter{$0.name?.contains("a") ?? false},
                               logo:"img_subject_android"),
                       Subject(name: "iOS",
                               teachers: defaultTeachers.filter{$0.name?.contains("o") ?? false},
                               students: defaultStudents.filter{$0.name?.contains("e") ?? false},
                               logo:"img_subject_ios"),
                       Subject(name: "JavaScript",
                               teachers: defaultTeachers.filter{$0.name?.contains("i") ?? false},
                               students: defaultStudents.filter{$0.name?.contains("i") ?? false},
                               logo:"img_subject_javascript"),
                       Subject(name: "Python",
                               teachers: defaultTeachers.filter{$0.name?.contains("e") ?? false},
                               students: defaultStudents.filter{$0.name?.contains("o") ?? false},
                               logo:"img_subject_python"),
                       Subject(name: "Dart",
                               teachers: defaultTeachers.filter{$0.name?.contains("a") ?? false},
                               students: defaultStudents.filter{$0.name?.contains("u") ?? false},
                               logo:"img_subject_dart")]
