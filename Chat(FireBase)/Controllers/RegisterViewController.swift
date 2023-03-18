//
//  RegisterViewController.swift
//  Chat(FireBase)
//
//  Created by Aleksandra Asichka on 2023-03-14.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        guard let email = emailTF.text, let password = passwordTF.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authRezult, error in
            if let currentError = error {
                print(currentError.localizedDescription)
            } else {
                self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
            }
        }
    }
}
