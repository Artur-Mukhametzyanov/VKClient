//
//  ShadowView.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 10.12.2021.
//

import UIKit

@IBDesignable class ShadowView: UIView {
    
    @IBInspectable var shadowColor: UIColor = .green
    @IBInspectable var shadowRadius: CGFloat = 7
    @IBInspectable var shadowOpacity: Float = 0.75
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.cornerRadius = bounds.height/2
    }
}
