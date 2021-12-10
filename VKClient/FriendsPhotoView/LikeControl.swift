//
//  LikeControl.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 10.12.2021.
//

import UIKit

class LikeControl: UIControl {

    public var likePressed: Bool = false
    let likeImageView = UIImageView()
    
    override init (frame: CGRect) {
        super.init (frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likeImageView.isUserInteractionEnabled = true
        likeImageView.addGestureRecognizer(tapGR)
        
        addSubview(likeImageView)
        likeImageView.image = UIImage(named: "likeEmpty")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        likeImageView.frame = bounds
    }
    
    @objc func likeTapped() {
        
        likePressed.toggle()
        if likePressed == true {
            likeImageView.image = UIImage(named: "likeTapped")
        } else {
            likeImageView.image = UIImage(named: "likeEmpty")
        }
        sendActions(for: .valueChanged)
        
    }
}


