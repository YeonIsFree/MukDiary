//
//  CollectionViewController.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/26.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    var removeToken: NSObjectProtocol?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) {
            if let vc = segue.destination as? DetailViewController {
                vc.diary = DataManager.shared.diaryList[indexPath.row]
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataManager.shared.fetchDiary()
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.diaryList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! PhotoCollectionViewCell
       
        let imgData = DataManager.shared.diaryList[indexPath.row].photo

        if let diaryPhoto = imgData {
            cell.collectionImageView.image = UIImage(data: diaryPhoto)
        }

        return cell
    }
}
