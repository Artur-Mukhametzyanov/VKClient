//
//  FriendsPhotoCell.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 13.11.2020.
//

import UIKit

class FriendsPhotoCell: UICollectionViewCell {
    
    var friendsPhotosController: FriendsPhotosController?
    
    @IBOutlet weak var friendsPhotoCell: UIImageView!
    @IBOutlet weak var likeCounter: UILabel!
    @IBOutlet weak var likeControl: LikeControl!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        likeControl.addTarget(self, action: #selector(likeTapped(sender:)), for: .valueChanged)
        
        friendsPhotoCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomTap)))
    }
}

extension FriendsPhotoCell {
    
    @objc func likeTapped (sender: LikeControl) {
        if (sender.likePressed == true) {
            likeCounter.text = "1"
            likeCounter.textColor = .red
            
            UIView.animate(withDuration: 0.15, animations: {
                self.likeControl.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
            
            UIView.animate(withDuration: 0.15, delay: 0.15, animations: {
                self.likeControl.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
            
        } else {
            likeCounter.text = "0"
            likeCounter.textColor = .black
        }
    }
    
    // функция увеличения изображения по клику (настроена в контроллере)
    @objc func handleZoomTap(tapGesture: UITapGestureRecognizer) {
 
        if let imageView = tapGesture.view as? UIImageView {
            self.friendsPhotosController?.performZoomInForImageView(startingImageView: imageView)
        }
    }
}
