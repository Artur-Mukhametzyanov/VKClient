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
}
