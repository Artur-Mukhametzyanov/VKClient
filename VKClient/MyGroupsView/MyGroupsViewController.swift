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
    
    var filteredArray: [Group]!
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        filteredArray = myGroupsArray
    }
}

extension MyGroupsViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK: - Table view delegate and DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as? MyGroupCell else { return UITableViewCell() }
        cell.myGroupImage.image = filteredArray[indexPath.row].groupsImage
        cell.myGroupName.text = filteredArray[indexPath.row].groupsName
        return cell
    }
    
    //MARK: - Search bar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredArray = []
        
        if searchText == "" {
            filteredArray = myGroupsArray
        } else {
            for singleGroup in myGroupsArray {
                if singleGroup.groupsName.lowercased().contains(searchText.lowercased()) {
                    filteredArray?.append(singleGroup)
                }
            }
        }
        tableView.reloadData()
    }
    
    //MARK: - Deleting groups
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            filteredArray.remove(at: indexPath.row)
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
            
            guard !filteredArray.contains(where: { group in
                return group.groupsName == newGroup.groupsName}) else { return }
            
            self.filteredArray.append(newGroup)
            self.myGroupsArray.append(newGroup)
            tableView.reloadData()
        }
    }
}

