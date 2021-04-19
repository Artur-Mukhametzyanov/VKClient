//
//  FriendsPhotosControllerCollectionViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 13.11.2020.
//

import UIKit

class FriendsPhotosController: UICollectionViewController {
    
    var photosArray = [UIImage]()
    public var friendsName = ""
    public var friendsID = 0
    var startingFrame: CGRect?
    var blackBackgroundView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = friendsName
        urlSessionResponse()
    }
}

extension FriendsPhotosController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotoCell", for: indexPath) as! FriendsPhotoCell
            
        cell.friendsPhotosController = self
        cell.friendsPhotoCell.image = photosArray[indexPath.row]
            
        return cell
    }
}

extension FriendsPhotosController {
    
    // MARK: - Запрос к сети и получение данных
    func urlSessionResponse() {

        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.getAll"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sessionInstance.token),
            URLQueryItem(name: "v", value: "5.130"),
            URLQueryItem(name: "owner_id", value: String(friendsID)),
        ]

        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            let dict = json as! [String: Any]
            let responseJson = dict["response"] as! [String: Any]
            let friendsAlbumsArray = responseJson["items"] as! [Any]
            for album in friendsAlbumsArray {
                let sizesDict = album as! [String: Any]
                let sizes = sizesDict["sizes"] as! [Any]
                for picture in sizes {
                    let sizesItem = picture as! [String: Any]
                    let height = sizesItem["height"] as! Int
                    if height >= 300 {
                        let friendPhotoURL = sizesItem["url"] as! String
                        
                        let friendsPhoto = UIImage(data: try! Data(contentsOf: URL(string: friendPhotoURL)!))
                        self.photosArray.append(friendsPhoto!)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
 
        task.resume()
    }
    
    // функция зумирования фотографии при нажатии
    func performZoomInForImageView(startingImageView: UIImageView) {
    
        startingFrame = startingImageView.superview?.convert(startingImageView.frame, to: nil)
        
        let zoomingImageView = UIImageView(frame: startingFrame!)
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.backgroundColor = UIColor.red
        zoomingImageView.image = startingImageView.image
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            blackBackgroundView = UIView(frame: keyWindow.frame)
            blackBackgroundView?.backgroundColor = UIColor.black
            blackBackgroundView?.alpha = 0
            keyWindow.addSubview(blackBackgroundView!)
            keyWindow.addSubview(zoomingImageView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackBackgroundView?.alpha = 1
                let height = self.startingFrame!.height / self.startingFrame!.width * keyWindow.frame.width
                zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                zoomingImageView.center = keyWindow.center
                
            }, completion: { (completed) in
            })
        }
    }
    
    // функция уменьшения зумированной фотографии
    @objc func handleZoomOut(tapGesture: UITapGestureRecognizer) {
        
        if let zoomOutImageView = tapGesture.view {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroundView?.alpha = 0
                
            }, completion: { (completed) in
                zoomOutImageView.removeFromSuperview()
            })
        }
    }
}
