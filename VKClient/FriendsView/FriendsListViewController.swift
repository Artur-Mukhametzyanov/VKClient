//
//  FriendsListViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 01.12.2021.
//

import UIKit

class FriendsListViewController: UIViewController {
    //MARK: - Data
    var friendsArray: [Friend] = [Friend(friendsImage: UIImage(named: "jackson")!, friendsName: "Michael Jackson"),
                                  Friend(friendsImage: UIImage(named: "chuck")!, friendsName: "Chuck Norris"),
                                  Friend(friendsImage: UIImage(named: "mithun")!, friendsName: "Mithun Chakraborty"),
                                  Friend(friendsImage: UIImage(named: "sasha")!, friendsName: "Sasha Grey"),
                                  Friend(friendsImage: UIImage(named: "nikita")!, friendsName: "Никита Джигурда"),
                                  Friend(friendsImage: UIImage(named: "jackson")!, friendsName: "101 Далматинец"),
                                  Friend(friendsImage: UIImage(named: "chuck")!, friendsName: "Борис Бритва"),
                                  Friend(friendsImage: UIImage(named: "mithun")!, friendsName: "Барбарис Бритва"),
                                  Friend(friendsImage: UIImage(named: "sasha")!, friendsName: "102 Далматинца"),
                                  Friend(friendsImage: UIImage(named: "nikita")!, friendsName: "Виктор Длинноволосый"),
    ]

    var sortedFriendsArray: [Friend] = []
    var firstLettersArray: [Character] = []
    var friendsDict: [String: [Friend]] = [:]
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        arraySorting()
        gettingFirstLetters()
        creatingDict()
        
    }
}


extension FriendsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableViewDelegate&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return firstLettersArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedFriendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        cell.friendsImage.image = sortedFriendsArray[indexPath.row].friendsImage
        cell.friendsName.text = sortedFriendsArray[indexPath.row].friendsName
        return cell
    }
    
    //MARK: - Separating by sections
    func arraySorting() {
        sortedFriendsArray = friendsArray.sorted {
            $0.friendsName < $1.friendsName
        }
    }

    func gettingFirstLetters() {
        for name in sortedFriendsArray {
            if !firstLettersArray.contains(name.friendsName.first!) {
                firstLettersArray.append(name.friendsName.first!)
            }
        }
    }

    func creatingDict() {
        for friend in sortedFriendsArray {
            let firstLetterIndex = friend.friendsName.index(friend.friendsName.startIndex, offsetBy: 1)
            let friendsKey = String(friend.friendsName[..<firstLetterIndex])
            if var friendsValues = friendsDict[friendsKey] {
                friendsValues.append(friend)
                friendsDict[friendsKey] = friendsValues
            } else {
                friendsDict[friendsKey] = [friend]
            }
        }
    }
       

    
    //MARK: - Pass photo
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPhotos" {
            let indexPath = tableView.indexPathForSelectedRow
            let photo = sortedFriendsArray[indexPath!.row].friendsImage
            let photoVC = segue.destination as! FriendsPhotosViewController
            photoVC.photo = photo
        }
    }
}
