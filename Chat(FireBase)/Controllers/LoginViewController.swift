//
//  LoginViewController.swift
//  Chat(FireBase)
//
//  Created by Aleksandra Asichka on 2023-03-14.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {


    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func loginPressed(_ sender: UIButton) {
        guard let email = loginTF.text, let password = passwordTF.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) {  authRezult, error in
            if let currentError = error {
                print(currentError.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "LoginToChat", sender: self)
            }
        }
    }
}
