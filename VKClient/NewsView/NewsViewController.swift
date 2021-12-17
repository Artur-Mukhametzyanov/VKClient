//
//  NewsViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 14.12.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    //MARK: - Data
    var newsArray: [NewsStruct] = [NewsStruct(newsSourceImage: UIImage(named: "beach"), newsSourceName: "Новостная новость", newsText: "Классический текст-«рыба». Является искажённым отрывком из философского трактата Марка Туллия Цицерона «О пределах добра и зла», написанного в 45 году до н. э. на латинском языке", newsImage: UIImage(named: "newsPhoto"))]

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Table view delegate and data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else { return UITableViewCell() }
        
        cell.newsAvatarImage.image = newsArray[indexPath.row].newsSourceImage
        cell.newsSourceName.text = newsArray[indexPath.row].newsSourceName
        cell.newsTextLabel.text = newsArray[indexPath.row].newsText
        cell.newsImage.image = newsArray[indexPath.row].newsImage
        
        return cell
    }
}
