//
//  FriendsListTableView.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 12.11.2020.
//

import UIKit

class FriendsListTableView: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchFriendsArray = [String]()
    var isSearching = false
    var firstLetterArray = [String]()
    var friendsDict = [String: [String]]()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatingDict()
        urlSessionRequest()
    }
    
    //MARK: - Заполняем таблицу
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return searchFriendsArray.count
        } else {
            let friendsKey = firstLetterArray[section]
            guard let friendsValues = friendsDict[friendsKey] else {return 0}
            return friendsValues.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let friendCell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
        if isSearching {
            friendCell.friendNameLabel?.text = searchFriendsArray[indexPath.row]
        } else {
            let friendsKey = firstLetterArray[indexPath.section]
            if let friendsValues = friendsDict[friendsKey] {
                friendCell.friendNameLabel?.text = friendsValues[indexPath.row]
            }
        }
        return friendCell
    }
    
    // MARK: - Разбиваем на секции
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching {
            return 1
        } else {
            return firstLetterArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching {
            return ""
        } else {
            return firstLetterArray[section]
        }
    }
    
    // Создаем селектор по буквам
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return firstLetterArray
    }
    
    // MARK: - Передаем имя друга в список фотографий
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFriendsPhoto",
            let friendsPhotoController = segue.destination as? FriendsPhotosController,
            let indexPath = tableView.indexPathForSelectedRow {
            let friendsName = myFriends[indexPath.row]
            friendsPhotoController.friendsName = friendsName
        }   
    }
    
    //MARK: - Создаем массив словарей [Буква: [ИмяДруга]]
    func creatingDict() {
        
        for friend in myFriends {
            let firstLetterIndex = friend.index(friend.startIndex, offsetBy: 1)
            let friendsKey = String(friend[..<firstLetterIndex])
            
            if var friendsValues = friendsDict[friendsKey] {
                friendsValues.append(friend)
                friendsDict[friendsKey] = friendsValues
            } else {
                friendsDict[friendsKey] = [friend]
            }
        }
        
        // Создаем массив первых букв и сортируем их по алфавиту
        firstLetterArray = [String](friendsDict.keys)
        firstLetterArray = firstLetterArray.sorted(by: {$0 < $1})
    }
}

//MARK: - делаем поисковик
extension FriendsListTableView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFriendsArray = myFriends.filter({$0.prefix(searchText.count) == searchText})
        isSearching = true
        tableView.reloadData()
        if searchBar.text == "" {
            isSearching = false
            tableView.reloadData()
        }
    }
    
    func urlSessionRequest() {
 
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sessionInstance.token),
            URLQueryItem(name: "v", value: "5.130"),
            URLQueryItem(name: "service_token", value: "5edceea05edceea05edceea0535eabc68555edc5edceea03eb884a4c1980f3fc78dfa13")
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        }
        task.resume()
    }
}
