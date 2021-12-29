//
//  LoginViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 25.11.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - outlets
    
    @IBOutlet weak var firstRound: UIView!
    @IBOutlet weak var secondRound: UIView!
    @IBOutlet weak var thirdRound: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func enterButton(_ sender: Any) {
    }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        viewCustomization()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        launchLoader()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension LoginViewController {
    //MARK: - View customization
    func viewCustomization() {
        firstRound.layer.cornerRadius = firstRound.layer.bounds.width/2
        secondRound.layer.cornerRadius = secondRound.layer.bounds.width/2
        thirdRound.layer.cornerRadius = thirdRound.layer.bounds.width/2
    }
    
    //MARK: - Loader animation
    func launchLoader() {
        UIView.animate(withDuration: 0.1,
                       animations: {self.firstRound.alpha = 0.3}) { (_) in
            UIView.animate(withDuration: 0.2,
                           animations: {self.firstRound.alpha = 1}) { (_) in
                UIView.animate(withDuration: 0.1,
                               animations: {self.secondRound.alpha = 0.3}) { (_) in
                    UIView.animate(withDuration: 0.2,
                                   animations: {self.secondRound.alpha = 1}) { (_) in
                        UIView.animate(withDuration: 0.1,
                                       animations: {self.thirdRound.alpha = 0.3}) {(_) in
                            UIView.animate(withDuration: 0.2,
                                           animations: {self.thirdRound.alpha = 1}, completion: { [weak self] _ in
                                self?.launchLoader()
                            })
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Authorization
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == "enterSegue" else {return true}
        
        let password = ""
        let login = ""
        
        if loginField.text == login,
           passwordField.text == password {
            return true
        } else {
            showLoginError()
            return false
        }
    }
    
    func showLoginError() {
        loginField.text = ""
        passwordField.text = ""
        let alert = UIAlertController(title: "Ошибка входа", message: "Неверный логин/пароль", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    // MARK: - Keyboard
    @objc func keyboardWasShown(notification: Notification) {
        
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
}
