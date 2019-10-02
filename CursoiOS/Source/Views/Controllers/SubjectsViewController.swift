//
//  SubjectsViewController.swift
//  CursoiOS
//
//  Created by Vbandin on 26/09/2019.
//  Copyright © 2019 ds. All rights reserved.
//

import UIKit

// MARK: - SubjectsViewController
class SubjectsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var cellSpacing: CGFloat = 16.0
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.reloadData()
    }

}




// MARK: - Extension navigation
extension SubjectsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SubjectDetailViewController,
              let cell = sender as? UICollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else {
            return
        }

        destination.subject = defaultSubjects[indexPath.row]
    }
}


// MARK: - Extension CollectionView methods
extension SubjectsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// Configure collectionView with default options
    func configureView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return defaultSubjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailViewCell.cellIdentifier,
                                                       for: indexPath) as? DetailViewCell else {
            return UICollectionViewCell()
        }
        
        if (indexPath.row < defaultSubjects.count) {
            let subject = defaultSubjects[indexPath.row]
            cell.configureCell(image: subject.logo,
                               title: subject.name)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.frame.size.width - cellSpacing) / 2
        return CGSize(width: size,
                      height: size)
    }
}

