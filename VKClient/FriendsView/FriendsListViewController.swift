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
                                  Friend(friendsImage: UIImage(named: "nikita")!, friendsName: "Никита Джигурда")
    ]
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension FriendsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableViewDelegate&DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        cell.friendsImage.image = friendsArray[indexPath.row].friendsImage
        cell.friendsName.text = friendsArray[indexPath.row].friendsName
        return cell
    }
    
    //MARK: - Pass photo
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPhotos" {
            let indexPath = tableView.indexPathForSelectedRow
            let photo = friendsArray[indexPath!.row].friendsImage
            let photoVC = segue.destination as! FriendsPhotosViewController
            photoVC.photo = photo
        }
    }
}
