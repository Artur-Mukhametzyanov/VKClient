//
//  MyGroupCell.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 01.12.2021.
//

import UIKit

class MyGroupCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var myGroupImage: UIImageView!
    @IBOutlet weak var myGroupName: UILabel!
    
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

extension MyGroupCell {
    
    //MARK: - Cell customization
    func cellCustomization() {
        myGroupImage.layer.cornerRadius = myGroupImage.bounds.width/2
    }
    
    //MARK: - Tap on image
    func addTapGesture() {
        myGroupImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageAnimation(_:)))
        myGroupImage.addGestureRecognizer(tap)
    }
    
    @objc func imageAnimation(_ sender: Any) {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.8
        animation.toValue = 1
        animation.stiffness = 400
        animation.mass = 2
        animation.duration = 2
        self.myGroupImage.layer.add(animation, forKey: nil)
    }
}

