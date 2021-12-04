//
//  MyGroupsViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 01.12.2021.
//

import UIKit

class MyGroupsViewController: UIViewController {
    
    //MARK: - Data
    var myGroupsArray: [Group] = [Group(groupsImage: UIImage(named: "shaurma")!, groupsName: "Клуб любителей шаурмы"),
                                  Group(groupsImage: UIImage(named: "guitar")!, groupsName: "Дрынькаем на гитаре"),
                                  Group(groupsImage: UIImage(named: "sector")!, groupsName: "We Are Сектор Газа"),
    ]
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MyGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Delegate and DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupCell
        cell.myGroupImage.image = myGroupsArray[indexPath.row].groupsImage
        cell.myGroupName.text = myGroupsArray[indexPath.row].groupsName
        return cell
    }
    
    //MARK: - Deleting groups
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            myGroupsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Adding groups
    @IBAction func addCity(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addCity" {
            
            guard let allGroupsVC = segue.source as? AllGroupsViewController else { return }
            let indexPath = allGroupsVC.tableView.indexPathForSelectedRow
            let newGroup = allGroupsVC.allGroupsArray[indexPath!.row]
            
            guard !myGroupsArray.contains(where: { group in
                return group.groupsName == newGroup.groupsName}) else { return }
            
            self.myGroupsArray.append(newGroup)
            tableView.reloadData()
        }
    }
}

