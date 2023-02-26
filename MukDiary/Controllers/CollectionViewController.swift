//
//  CollectionViewController.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/26.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//        if segue.identifier == "mySegue"
//        {
//            let viewController = segue.destination as! AnimalsViewController1
//            print("In \(#function), valueToPass = \(valueToPass)")
//            viewController.dataLabelObject = valueToPass
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) {
            if let vc = segue.destination as? DetailViewController {
                vc.diary = DataManager.shared.diaryList[indexPath.row]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.allowsSelection = true
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return DataManager.shared.diaryList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! PhotoCollectionViewCell
        
        let img = DataManager.shared.diaryList[indexPath.row].photo
        
        if let diaryPhoto = img {
            cell.collectionImageView.image = UIImage(data: diaryPhoto)
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate
//
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "detailViewSegue", sender: self)
//
//    }
    


}
