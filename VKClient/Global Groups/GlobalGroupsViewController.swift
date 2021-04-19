//
//  GlobalGroupsViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 07.11.2020.
//

import UIKit

class GlobalGroupsViewController: UIViewController {
    
    var globalGroupsArray = [GroupsStruct]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
}

extension GlobalGroupsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalGroupsCell", for: indexPath) as! GlobalGroupsCell
        cell.globalGroupLabel.text = globalGroupsArray[indexPath.row].groupName
        cell.globalGroupImage.image = globalGroupsArray[indexPath.row].groupPhoto
        return cell
    }
}

extension GlobalGroupsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" {
            globalGroupsArray.removeAll()
            tableView.reloadData()
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
            
            let dict = json as! [String: Any]
            let responseJson = dict["response"] as! [String: Any]
            let groupsArray = responseJson["items"] as! [Any]
            for group in groupsArray {
                let groupItem = group as! [String: Any]
                let groupName = groupItem["name"] as! String
                let groupPhotoURL = groupItem["photo_100"] as! String
                let globalGroupPhoto = UIImage(data: try! Data(contentsOf: URL(string: groupPhotoURL)!))
                
                let globalGroup = GroupsStruct(groupName: groupName, groupPhoto: globalGroupPhoto!)
                self.globalGroupsArray.append(globalGroup)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        task.resume()
    }
}

