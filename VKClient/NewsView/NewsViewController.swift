//
//  NewsViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 14.12.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    let news = ["news 1", "news 2", "news 3"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            return headerCell
        case 1:
            let groupCell = tableView.dequeueReusableCell(withIdentifier: "GroupTextCell", for: indexPath) as! GroupTextCell
            return groupCell
        case 2:
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "GroupImageCell", for: indexPath) as! GroupImageCell
            return imageCell
        case 3:
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalInfoCell", for: indexPath) as! AdditionalInfoCell
            return infoCell
        default:
            return UITableViewCell()
        }
    }
}
