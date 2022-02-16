//
//  AllGroupsViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 02.12.2021.
//

import UIKit

class AllGroupsViewController: UIViewController {
    
    //MARK: - Data
//    var allGroupsArray: [Group] = [Group(groupsImage: UIImage(named: "beach") ?? UIImage(), groupsName: "Море и песок")]
    
    var allGroupsArray: [GroupsItems] = []
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
}

extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Delegate, DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as? AllGroupsCell else { return UITableViewCell() }
        
        let picture = UIImage(data: try! Data(contentsOf: URL(string: allGroupsArray[indexPath.row].groupPhoto)!))
        
        cell.allGroupsImage.image = picture
        cell.allGroupsName.text = allGroupsArray[indexPath.row].groupName
        
        return cell
    }
}

extension AllGroupsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchGroupsRequest = AllGroupsInteractor()
        searchGroupsRequest.requestAllGroupsList(searchRequest: searchBar.text ?? "") { [weak self] response in
            self!.allGroupsArray = response.response.items
            self!.tableView.reloadData()
        }
    }
}
