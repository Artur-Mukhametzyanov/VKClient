//
//  FriendsPhotoCell.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 04.12.2021.
//

import UIKit

class FriendsPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var friendsPhotoImage: UIImageView!
    @IBOutlet weak var likeControl: LikeControl!
    @IBOutlet weak var counter: UILabel!
    
    override func awakeFromNib() {
        
        likeControl.addTarget(self, action: #selector(likePressed(_:)), for: .valueChanged)
    }
}

extension FriendsPhotoCell {
    
    @objc func likePressed(_ sender: LikeControl) {
        
        if likeControl.likePressed == true {
            counter.textColor = .red
            counter.text = "1"
        } else {
            counter.textColor = .black
            counter.text = "0"
        }
    }
}

