//
//  FriendsPhotosViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 04.12.2021.
//

import UIKit

class FriendsPhotosViewController: UIViewController {

    //MARK: - Data
    var photo: UIImage?
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension FriendsPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
    //MARK: - Delegate, DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotoCell", for: indexPath) as? FriendsPhotoCell else { return UICollectionViewCell() }
        
        cell.friendsPhotoImage.image = photo
        return cell
    }

}
