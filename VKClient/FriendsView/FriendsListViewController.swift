//
//  FriendsListViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 01.12.2021.
//

import UIKit

class FriendsListViewController: UIViewController {
    //MARK: - Data
    var friendsArray: [Friend] = [Friend(friendsImage: UIImage(named: "jackson") ?? UIImage(), friendsName: "Michael Jackson"),
                                  Friend(friendsImage: UIImage(named: "chuck") ?? UIImage(), friendsName: "Chuck Norris"),
                                  Friend(friendsImage: UIImage(named: "mithun") ?? UIImage(), friendsName: "Mithun Chakraborty"),
                                  Friend(friendsImage: UIImage(named: "sasha") ?? UIImage(), friendsName: "Sasha Grey"),
                                  Friend(friendsImage: UIImage(named: "nikita") ?? UIImage(), friendsName: "Никита Джигурда"),
    ]

    var sortedFriendsArray: [Friend] = []
    var firstLettersArray: [Character] = []
    var stringArray: [String] = []
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
        
        let friendsInteractor = FriendsInteractor()
        friendsInteractor.requestFriendsList()
        
    }
}

extension FriendsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableViewDelegate&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return firstLettersArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(firstLettersArray[section])
    }
    

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        for element in firstLettersArray {
            let letter = String(element)
            stringArray.append(letter)
        }
        return stringArray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let friendsKey = String(firstLettersArray[section])
        guard let friendsValues = friendsDict[friendsKey] else { return 0 }
        return friendsValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsCell else { return UITableViewCell() }
        
        let friendsKey = firstLettersArray[indexPath.section]
        if let friendsValues = friendsDict[String(friendsKey)] {
            
            cell.friendsName.text = friendsValues[indexPath.row].friendsName
            cell.friendsImage.image = friendsValues[indexPath.row].friendsImage
            
        }
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
            if !firstLettersArray.contains((name.friendsName.first!)) {
                firstLettersArray.append((name.friendsName.first!))
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
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let key = firstLettersArray[indexPath.section]
            let photo = friendsDict[String(key)]![indexPath.row].friendsImage
            guard let photoVC = segue.destination as? FriendsPhotosViewController else { return }
            photoVC.photo = photo
            
        }
    }
}
