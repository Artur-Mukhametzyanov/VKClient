//
//  myGroupCell.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 05.11.2020.
//

import UIKit

class MyGroupCell: UITableViewCell {
    
    @IBOutlet weak var myGroupImage: ClippedView!
    @IBOutlet weak var groupName: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.imgTapped))
        myGroupImage.addGestureRecognizer(tap)
        
    }
}

extension MyGroupCell {
    
    @objc func imgTapped() {
    
        UIView.animate(withDuration: 0.05, animations: {
            self.myGroupImage.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        })
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.05,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.5,
                       options: [],
                       animations: {self.myGroupImage.transform = CGAffineTransform(scaleX: 1, y: 1)})
    }
    
}
