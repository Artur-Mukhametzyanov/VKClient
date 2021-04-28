//
//  FriendsListTableView.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 12.11.2020.
//

import UIKit
import RealmSwift

class FriendsListTableView: UITableViewController {
    
    var myFriendsArray = [MyFriendsStruct]()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        readingFromRealm()
        urlSessionRequest()
    }
}

extension FriendsListTableView {
    
    //MARK: - Конфигурируем таблицу
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFriendsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
        let friendsPhoto = UIImage(data: try! Data(contentsOf: URL(string: myFriendsArray[indexPath.row].friendsPhotoURL)!))
        cell.friendImageView.image = friendsPhoto
        cell.friendNameLabel.text = myFriendsArray[indexPath.row].friendsName
        
        return cell
    }
}

extension FriendsListTableView {
    
    // MARK: - Передаем имя друга и ID в список фотографий
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFriendsPhoto",
           let friendsPhotoController = segue.destination as? FriendsPhotosController,
           let indexPath = tableView.indexPathForSelectedRow {
            
            let friendsName = myFriendsArray[indexPath.row].friendsName
            friendsPhotoController.friendsName = friendsName
            
            let friendsID = myFriendsArray[indexPath.row].friendsID
            friendsPhotoController.friendsID = friendsID
        }
    }
    
    //MARK: - Запрос к сети и получение данных
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
            URLQueryItem(name: "fields", value: "photo_100"),
            URLQueryItem(name: "service_token", value: "5edceea05edceea05edceea0535eabc68555edc5edceea03eb884a4c1980f3fc78dfa13")
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) { [self] (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            let dict = json as! [String: Any]
            let responseJson = dict["response"] as! [String: Any]
            let friendsArray = responseJson["items"] as! [Any]
            for friend in friendsArray {
                let friendItem = friend as! [String: Any]
                let friendName = friendItem["first_name"] as! String
                let friendID = friendItem["id"] as! Int
                let friendLastName = friendItem["last_name"] as! String
                let friendsPhotoURL = friendItem["photo_100"] as! String
                
                let friendFullName = friendName + " " + friendLastName
                
                let myFriend = MyFriendsStruct()
                myFriend.friendsName = friendFullName
                myFriend.friendsID = friendID
                myFriend.friendsPhotoURL = friendsPhotoURL
                
                self.myFriendsArray.append(myFriend)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                savingToRealm()
            }
        }
        
        task.resume()
    }
    
    //MARK: - Сохранение данных в Realm
    func savingToRealm() {
        
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.deleteAll()
            realm.add(myFriendsArray)
            try realm.commitWrite()
        } catch {
            print ("saving friends in realm failed")
        }
    }
    
    //MARK: - Чтение данных Realm
    func readingFromRealm() {
        
        do {
            let realm = try Realm()
            let realmFriends = realm.objects(MyFriendsStruct.self)
            self.myFriendsArray = Array(realmFriends)
            
        } catch {
            print(error)
        }
    }
}
