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
    @IBOutlet weak var friendsName: UILabel!
    
    //MARK: - Lifecycle
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
}
