//
//  StudentDetailViewController.swift
//  CursoiOS
//
//  Created by Vbandin on 01/10/2019.
//  Copyright © 2019 ds. All rights reserved.
//

import UIKit

// MARK: - StudentDetailViewController
class StudentDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var section1Label: UILabel!
    @IBOutlet weak var section2Label: UILabel!
    @IBOutlet var dataCollectionView: Array<UICollectionView>!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - IBAction
    @IBAction func onDeletePressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Eliminar estudiante", message: "Vas a eliminar un estudiante, ¿estas seguro?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: {[weak self] _ in
                        defaultStudents.removeAll(where: {$0.name == self?.student?.name ?? ""})
            self?.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: {[weak self] _ in
            
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    
    // MARK: - Properties
    var student: Student?
    
    private var mStudentSubjects: Array<Subject> = []
    private var mStudentTeachers: Array<Teacher> = []

    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(image: student?.avatar)
        configure(title: student?.name)
        configure(subtitle: "")
        configure(section1: "Subjects")
        configure(section2: "Teachers")
        
        loadSubjectsAndTeachers(for: student?.name)
        configureCollectionsView()
    }
    
    // MARK: - Configure methods
    private func configure(image: String?) {
        guard let imageData = image else {
            imageView.image = nil
            return
        }
        
        imageView.image = UIImage(named: imageData)
    }
    
    private func configure(title: String?) {
        titleLabel.text = title
    }
    
    private func configure(subtitle: String?) {
        subtitleLabel.text = subtitle
    }
    
    private func configure(section1: String?) {
        section1Label.text = section1
    }
    
    private func configure(section2: String?) {
        section2Label.text = section2
    }
    
    private func configureCollectionsView() {
        dataCollectionView.forEach{ collectionView in
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    // MARK: - Load content methods
    private func loadSubjectsAndTeachers(for studentName: String?) {
        guard let name = studentName else {
            return
        }
        
        mStudentSubjects = filter(subjects: defaultSubjects,
                                  by: name)
        
        mStudentTeachers = Array(teachers(for: mStudentSubjects))
    }

    /// Filter Subjects with Student name and return only subjects for StudentName
    private func filter(subjects data: [Subject], by studentName: String) -> [Subject] {
        let studentSubjects = data.filter({ subject in
            let subjectStudents = filter(students: subject.students,
                                         by: studentName)
            
            return subjectStudents.count > 0
        })
        
        return studentSubjects
    }
    
    /// Filter Students with Student name and return only students for StudentName
    private func filter(students data: [Student], by studentName: String) -> [Student] {
        let studentsForName = data.filter({ subjectStudent in
            guard let subjectStudentName = subjectStudent.name else {
                return false
            }
            
            return subjectStudentName == studentName
        })
        
        return studentsForName
    }

    /// Find Teachers in Subjects and return Set of teachers for this Subjects
    private func teachers(for data: [Subject]) -> Set<Teacher> {
        var subjectsTeachers: Set<Teacher> = Set<Teacher>()
        data.forEach{ subject in
            subject.teachers.forEach{ subjectsTeachers.insert($0) }
        }
        
        return subjectsTeachers
    }
}


// MARK: - Extension CollectionView
extension StudentDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
            case 0:
                return mStudentSubjects.count

            case 1:
                return mStudentTeachers.count
        
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
                if indexPath.row < mStudentSubjects.count {
                    let subject = mStudentSubjects[indexPath.row]
                    cell.configureCell(image: subject.logo,
                                       title: subject.name)
                }
            
            case 1:
                if indexPath.row < mStudentTeachers.count {
                    let teacher = mStudentTeachers[indexPath.row]
                    cell.configureCell(image: teacher.avatar,
                                       title: teacher.name)
                }
            
            default:
                return UICollectionViewCell()
        }
        
        return cell
    }
}
