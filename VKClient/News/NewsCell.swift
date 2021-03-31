//
//  NewsCell.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 20.01.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsSourceName: UILabel!
    @IBOutlet weak var newsSourceImage: ClippedView!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
}

