//
//  AllGroupsViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 02.12.2021.
//

import UIKit

class AllGroupsViewController: UIViewController {
    
    //MARK: - Data
    var allGroupsArray: [Group] = [Group(groupsImage: UIImage(named: "beach") ?? UIImage(), groupsName: "Море и песок")]
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Delegate, DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as? AllGroupsCell else { return UITableViewCell() }
        cell.allGroupsImage.image = allGroupsArray[indexPath.row].groupsImage
        cell.allGroupsName.text = allGroupsArray[indexPath.row].groupsName
        return cell
    }
}
