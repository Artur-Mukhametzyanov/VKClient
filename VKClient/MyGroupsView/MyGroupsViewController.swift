//
//  MyGroupsViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 01.12.2021.
//

import UIKit

class MyGroupsViewController: UIViewController {
    
    //MARK: - Data
    //    var myGroupsArray: [Group] = [Group(groupsImage: UIImage(named: "shaurma") ?? UIImage(), groupsName: "Клуб любителей шаурмы"),
    //                                  Group(groupsImage: UIImage(named: "guitar") ?? UIImage(), groupsName: "Дрынькаем на гитаре"),
    //                                  Group(groupsImage: UIImage(named: "sector") ?? UIImage(), groupsName: "We Are Сектор Газа"),
    //    ]
    
    var myGroupsArray: [GroupsItems] = []
    var filteredArray: [GroupsItems] = []
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
}

extension MyGroupsViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK: - Table view delegate and DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as? MyGroupCell else { return UITableViewCell() }
        
        let picture = UIImage(data: try! Data(contentsOf: URL(string: filteredArray[indexPath.row].groupPhoto)!))
        
        cell.myGroupImage.image = picture
        cell.myGroupName.text = filteredArray[indexPath.row].groupName
        return cell
    }
    
    //MARK: - Search bar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredArray = []
        
        if searchText == "" {
            filteredArray = myGroupsArray
        } else {
            for singleGroup in myGroupsArray {
                if singleGroup.groupName.lowercased().contains(searchText.lowercased()) {
                    filteredArray.append(singleGroup)
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
    
    //MARK: - Getting data
    func getData() {
        let myGroupsInteractor = MyGroupsInteractor()
        myGroupsInteractor.requestMyGroupsList { [weak self] response in
            self!.myGroupsArray = response.response.items
            self!.filteredArray = self!.myGroupsArray
            self!.tableView.reloadData()
        }
    }
    
    // MARK: - Adding groups
    @IBAction func addGroup(segue: UIStoryboardSegue) {

        if segue.identifier == "addGroup" {

            guard let allGroupsVC = segue.source as? AllGroupsViewController else { return }
            let indexPath = allGroupsVC.tableView.indexPathForSelectedRow
            let newGroup = allGroupsVC.allGroupsArray[indexPath!.row]

            guard !filteredArray.contains(where: { group in
                return group.groupName == newGroup.groupName}) else { return }

            self.filteredArray.append(newGroup)
            self.myGroupsArray.append(newGroup)
            tableView.reloadData()
        }
    }
}

