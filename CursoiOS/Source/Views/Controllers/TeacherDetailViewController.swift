//
//  TeacherDetailViewController.swift
//  CursoiOS
//
//  Created by Vbandin on 01/10/2019.
//  Copyright © 2019 ds. All rights reserved.
//

import UIKit

// MARK: - TeacherDetailViewController
class TeacherDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var section1Label: UILabel!
    @IBOutlet weak var section2Label: UILabel!
    @IBOutlet var dataCollectionView: Array<UICollectionView>!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - Properties
    // MARK: - IBAction
    @IBAction func onDeletePressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Eliminar profesor", message: "Vas a eliminar un profesor, ¿estas seguro?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: {[weak self] _ in
                        defaultTeachers.removeAll(where: {$0.name == self?.teacher?.name ?? ""})
            self?.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: {[weak self] _ in
            
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    
    // MARK: - Properties
    var teacher: Teacher?
    
    private var mTeacherSubjects: Array<Subject> = []
    private var mTeacherStudents: Array<Student> = []
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(image: teacher?.avatar)
        configure(title: teacher?.name)
        configure(subtitle: "")
        configure(section1: "Subjects")
        configure(section2: "Students")
        
        loadSubjectsAndStudents(for: teacher?.name)
        configureCollectionsView()
    }
    
    // MARK: - Configure methods
    func configure(image: String?) {
        guard let imageData = image else {
            imageView.image = nil
            return
        }
        
        imageView.image = UIImage(named: imageData)
    }
    
    func configure(title: String?) {
        titleLabel.text = title
    }
    
    func configure(subtitle: String?) {
        subtitleLabel.text = subtitle
    }
    
    func configure(section1: String?) {
        section1Label.text = section1
    }
    
    func configure(section2: String?) {
        section2Label.text = section2
    }
    
    func configureCollectionsView() {
        dataCollectionView.forEach{ collectionView in
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    // MARK: - Load content methods
    func loadSubjectsAndStudents(for teacherName: String?) {
        guard let name = teacherName else {
            return
        }
        
        mTeacherSubjects = filter(subjects: defaultSubjects,
                                  teacherName: name)
        
        mTeacherStudents = Array(students(for: mTeacherSubjects))
    }
    
    func filter(subjects data: [Subject], teacherName: String) -> [Subject] {
        let teacherSubjects = data.filter({ subject in
            let subjectTeachers = filter(teachers: subject.teachers,
                                         by: teacherName)
            
            return subjectTeachers.count > 0
        })
        
        return teacherSubjects
    }

    func filter(teachers data: [Teacher], by teacherName: String) -> [Teacher] {
        let teachersForName = data.filter({ subjectTeacher in
            guard let subjectTeacherName = subjectTeacher.name else {
                return false
            }
            
            return subjectTeacherName == teacherName
        })
        
        return teachersForName
    }

    func students(for data: [Subject]) -> Set<Student> {
        var subjectsStudents: Set<Student> = Set<Student>()
        data.forEach{ subject in
            subject.students.forEach{ subjectsStudents.insert($0) }
        }
        
        return subjectsStudents
    }
    
}

// MARK: - Extension CollectionView
extension TeacherDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
            case 0:
                return mTeacherSubjects.count
                
            case 1:
                return mTeacherStudents.count
                
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailViewCell.cellIdentifier,
                                                            for: indexPath) as? DetailViewCell else {
                                                                return UICollectionViewCell()
        }
        
        switch collectionView.tag {
            case 0:
                if indexPath.row < mTeacherSubjects.count {
                    let subject = mTeacherSubjects[indexPath.row]
                    cell.configureCell(image: subject.logo,
                                       title: subject.name)
                }
                
            case 1:
                if indexPath.row < mTeacherStudents.count {
                    let student = mTeacherStudents[indexPath.row]
                    cell.configureCell(image: student.avatar,
                                       title: student.name)
                }
                
            default:
                return UICollectionViewCell()
        }
        
        return cell
    }
    
}
