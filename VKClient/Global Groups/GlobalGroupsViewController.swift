//
//  GlobalGroupsViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 07.11.2020.
//

import UIKit

class GlobalGroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension GlobalGroupsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalGroupsCell", for: indexPath) as! GlobalGroupsCell
        let globalGroup = globalGroups[indexPath.row]
        cell.globalGroupLabel.text = globalGroup
        return cell
    }
    
}

