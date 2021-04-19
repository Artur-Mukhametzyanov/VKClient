//
//  MyGroupsController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 05.11.2020.
//

import UIKit

class MyGroupsController: UIViewController {

    var myGroupsArray = [GroupsStruct]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlSessionRequest()
    }

    @IBAction func addGroup (segue: UIStoryboardSegue) {
        if let allGroupsController = segue.source as? GlobalGroupsViewController,
            let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
            let group = allGroupsController.globalGroupsArray[indexPath.row]
                if !myGroupsArray.contains(group) {
                    myGroupsArray.append(group)
                self.tableView.reloadData()
            }
        }
    }
}

extension MyGroupsController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupCell
        cell.groupName.text = myGroupsArray[indexPath.row].groupName
        cell.myGroupImage.image = myGroupsArray[indexPath.row].groupPhoto
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroupsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension MyGroupsController {
    
    func urlSessionRequest() {
 
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sessionInstance.token),
            URLQueryItem(name: "v", value: "5.130"),
            URLQueryItem(name: "extended", value: "1")
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
                let myGroupPhoto = UIImage(data: try! Data(contentsOf: URL(string: groupPhotoURL)!))
                
                let myGroup = GroupsStruct(groupName: groupName, groupPhoto: myGroupPhoto!)
                self.myGroupsArray.append(myGroup)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        task.resume()
    }
}
