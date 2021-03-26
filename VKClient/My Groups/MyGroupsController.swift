//
//  MyGroupsController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 05.11.2020.
//

import UIKit

class MyGroupsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addGroup (segue: UIStoryboardSegue) {
        if let allGroupsController = segue.source as? GlobalGroupsViewController,
            let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                let group = globalGroups[indexPath.row]
                if !myGroups.contains(group) {
                myGroups.append(group)
                self.tableView.reloadData()
            }
        }
    }
    
}

extension MyGroupsController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupCell
        cell.groupName.text = myGroups[indexPath.row]
        cell.myGroupImage.image = UIImage(named: "KiS")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
