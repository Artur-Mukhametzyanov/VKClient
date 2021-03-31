//
//  LoginViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 25.10.2020.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func loginButton(_ sender: Any) {}
    @IBOutlet weak var textBackground: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func logOutSegue (_ sender: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appearanceCustomizer()
        
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        ScrollView?.addGestureRecognizer(hideKeyboardGesture)

    }
    
    // Настраиваем внешний вид контроллера
    func appearanceCustomizer() {
        textBackground.layer.cornerRadius = 15
        loginButton.layer.cornerRadius = 24
    }
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.ScrollView?.contentInset = contentInsets
        ScrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        ScrollView?.contentInset = contentInsets
        ScrollView?.scrollIndicatorInsets = contentInsets
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object:nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        self.ScrollView?.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (emailTextField.text == "" && passwordTextField.text == "") { 
            return true
        } else {
            let alertWindow = UIAlertController (title: "Ошибка", message: "Неверные данные пользователя", preferredStyle: .alert)
            let actionButton = UIAlertAction (title: "OK", style: .cancel, handler: nil)
            alertWindow.addAction(actionButton)
            present(alertWindow, animated: true, completion: nil)
            return false
        }
    }
}

    
