//
//  ChatViewController.swift
//  Chat(FireBase)
//
//  Created by Aleksandra Asichka on 2023-03-14.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTF: UITextField!
    
    var messages: [Message] = [
    Message(sender: "1@cat.com", body: "Hey!"),
    Message(sender: "2@cat.com", body: "Hello)"),
    Message(sender: "1@cat.com", body: "How is it going?!")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "⚡️FlashChat"
        navigationItem.hidesBackButton = true
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print(signOutError.localizedDescription)
        }
    }
    @IBAction func sendButtonPressed(_ sender: UIButton) {
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath)

        cell.textLabel?.text = messages[indexPath.row].body
        return cell
    }
    
}
