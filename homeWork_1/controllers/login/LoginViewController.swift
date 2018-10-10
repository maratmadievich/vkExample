//
//  LoginViewController.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30.09.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var customIndicator: CustomIndicator!
    
    
    @IBOutlet weak var labelLogin: UITextField!
    @IBOutlet weak var labelPass: UITextField!
    
    
    private var login = "login"
    private var pass = "pass"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustoms()
    }
    
    
    private func setCustoms() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor.white
        navigationBarAppearance.barTintColor = UIColor.vkColor.main
        
        
    }
    
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        tryLogin()
    }
    
    
    private func tryLogin() {
        var isAuth = true
        if (labelLogin.text?.count == 0 || labelPass.text?.count == 0) {
            isAuth = false
            showAlert(text: "Поле Логин и Пароль должны быть заполнены")
        }
        if (labelLogin.text != login || labelPass.text != pass) {
            isAuth = false
            showAlert(text: "Неверно введены Логин или Пароль")
        }
        if (isAuth) {
            getMyGroups()
            prepareShowMain()
        }
    }
    
    private func prepareShowMain() {
        customIndicator.isHidden = false
        customIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.customIndicator.isHidden = true
            self.customIndicator.stopAnimating()
            self.performSegue(withIdentifier: "showMain", sender: nil)
        }
       
    }
    
    
    private func getMyGroups() {
        let defaults = UserDefaults.standard
        if let groupArray = defaults.array(forKey: "groups") {
            GlobalConstants.groupList = groupArray as! [Int]
        } else {
            GlobalConstants.groupList = [0, 1, 2, 3]
            GlobalConstants.saveGroups()
            //            defaults.setValue(GlobalConstants.groupList, forKey: "groups")
            //            defaults.synchronize()
        }
    }
    
    
    private func showAlert(text: String) {
        let alert = UIAlertController(title: "Ошибка входа", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Понятно", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) {
        
    }
    
}
