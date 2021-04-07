//
//  GlobalGroupsViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 07.11.2020.
//

import UIKit

class GlobalGroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
}

extension GlobalGroupsViewController: UITableViewDataSource, UITableViewDelegate {

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

extension GlobalGroupsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text != "" {
            urlSessionRequest()
        }
    }
}

extension GlobalGroupsViewController {
    
    func urlSessionRequest() {
 
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.search"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sessionInstance.token),
            URLQueryItem(name: "q", value: searchBar.text),
            URLQueryItem(name: "v", value: "5.130")
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        }
        task.resume()
    }
}

