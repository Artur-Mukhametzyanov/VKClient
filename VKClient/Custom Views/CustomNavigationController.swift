//
//  CustomNavigationController.swift
//  VKClient
//
//  Created by Артур Мухаметзянов on 22.03.2021.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return PushControllerAnimation()
        } else if operation == .pop {
            return PopControllerAnimation()
        }
        return nil
    }

}



