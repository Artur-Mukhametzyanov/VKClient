//
//  File.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 21.12.2020.
//

import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.init(width: 0, height: 0.5)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 35
    }
    
}

class ClippedView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 35
    }
    
}
