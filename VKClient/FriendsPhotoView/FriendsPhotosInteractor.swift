//
//  FriendsPhotosInteractor.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 16.01.2022.
//

import Foundation
import Alamofire

class FriendsPhotosInteractor {
    
    func requestFriendsPhotos(ownerId: Int, completion: @escaping([UIImage]) -> Void){
        
        guard let token = Session.shared.token else {
            return
        }
        
        let url = "https://api.vk.com/method/photos.getAll"
        let parameters: Parameters = ["access_token": token,
                                      "owner_id": ownerId,
                                      "v": 5.131
        ]
        
        AF.request(url, method: .get, parameters: parameters).response { rawData in
            do {
                guard let data = rawData.data else { return }
                let response = try JSONDecoder().decode(PhotoResponse.self, from: data)
                
                //Создаем массив, состоящий только из урлов типа "q"
                let arrayOfPhotoItems: [PhotoItems] = response.response.items
                var arrayOfSinglePhotoURL: [String] = []
                
                for photo in arrayOfPhotoItems {
                    let allSizePhotoArray = photo.sizes
                    for singlePhoto in allSizePhotoArray {
                        if singlePhoto.type == "q" {
                            arrayOfSinglePhotoURL.append(singlePhoto.photoUrl)
                        }
                    }
                }
                
                //Создаем массив фотографий из урлов и грузим фото в него
                var photosArray: [UIImage] = []
                
                for photoUrl in arrayOfSinglePhotoURL {
                    let picture = UIImage(data: try! Data(contentsOf: URL(string: photoUrl)!))
                    photosArray.append(picture ?? UIImage())
                }

                completion(photosArray)
            } catch {
                print(error)
            }
        }
    }
}
