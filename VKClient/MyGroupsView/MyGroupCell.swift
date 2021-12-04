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
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellCustomization()
    }
}

extension MyGroupCell {
    
    //MARK: - Cell customization
    func cellCustomization() {
        
        myGroupImage.layer.cornerRadius = myGroupImage.layer.bounds.width/2
    }
}
