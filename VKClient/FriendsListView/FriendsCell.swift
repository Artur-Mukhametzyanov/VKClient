//
//  FriendsCell.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 01.12.2021.
//

import UIKit

class FriendsCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var friendsImage: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var secondName: UILabel!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addTapGesture()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellCustomization()
    }
}

extension FriendsCell {
    
    //MARK: - Cell customization
    func cellCustomization() {
        
        friendsImage.layer.cornerRadius = friendsImage.layer.bounds.width/2
    }
    
    //MARK: - Tap on image
    func addTapGesture() {
        friendsImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageAnimation(_:)))
        friendsImage.addGestureRecognizer(tap)
    }
    
    @objc func imageAnimation(_ sender: Any) {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.8
        animation.toValue = 1
        animation.stiffness = 400
        animation.mass = 2
        animation.duration = 2
        self.friendsImage.layer.add(animation, forKey: nil)
    }
}
