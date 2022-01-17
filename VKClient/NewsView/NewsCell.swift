//
//  NewsCell.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 14.12.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var newsAvatarImage: UIImageView!
    @IBOutlet weak var newsSourceName: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var likeImage: LikeControl!
    @IBOutlet weak var commentButton: UIImageView!
    @IBOutlet weak var commentCounter: UILabel!
    @IBOutlet weak var shareButton: UIImageView!
    @IBOutlet weak var shareCounter: UILabel!
    @IBOutlet weak var viewsCounter: UILabel!
    
    //MARK: - Lyfecycle
    override func awakeFromNib() {
        super.awakeFromNib()
       
        appearanceCustomize()
    }
}

extension NewsCell {
    
    func appearanceCustomize() {
        newsAvatarImage.layer.cornerRadius = newsAvatarImage.layer.bounds.width/2
    }
    
}
