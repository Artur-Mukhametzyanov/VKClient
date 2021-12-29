//
//  AllGroupsCell.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 02.12.2021.
//

import UIKit

class AllGroupsCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var allGroupsImage: UIImageView!
    @IBOutlet weak var allGroupsName: UILabel!
   
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

extension AllGroupsCell {
    
    //MARK: - Cell customization
    func cellCustomization() {
        
        allGroupsImage.layer.cornerRadius = allGroupsImage.layer.bounds.width/2
        allGroupsImage.layer.shadowRadius = 20
        allGroupsImage.layer.shadowColor = UIColor.black.cgColor
    }
    
    //MARK: - Tap on image
    func addTapGesture() {
        allGroupsImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageAnimation(_:)))
        allGroupsImage.addGestureRecognizer(tap)
    }
    
    @objc func imageAnimation(_ sender: Any) {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.8
        animation.toValue = 1
        animation.stiffness = 400
        animation.mass = 2
        animation.duration = 2
        self.allGroupsImage.layer.add(animation, forKey: nil)
    }
}
