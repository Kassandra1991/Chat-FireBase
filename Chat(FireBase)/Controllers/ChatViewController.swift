//
//  ChatViewController.swift
//  Chat(FireBase)
//
//  Created by Aleksandra Asichka on 2023-03-14.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTF: UITextField!
    
    let db = Firestore.firestore()
    
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
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: .main), forCellReuseIdentifier: Constants.cell)
        loadMessages()

    }
    func loadMessages() {
        messages = []
        db.collection(Constants.FStore.collectionName).addSnapshotListener { querySnapShot, error in
            if let currentError = error {
                print("Wrong getting data from Database: \(currentError.localizedDescription)")
            } else {
                if let docs = querySnapShot?.documents {
                    for doc in docs {
                        let data = doc.data()
                        if let sender = data[Constants.FStore.senderField] as? String, let body = data[Constants.FStore.bodyField] as? String {
                            self.messages.append(Message(sender:sender, body: body))
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
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
        if let messageBody = messageTF.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField: messageSender, Constants.FStore.bodyField: messageBody]) { error in
                if let currentError = error {
                    print("Trouble with saving data in firestore: \(currentError.localizedDescription)")
                } else {
                    print("Succsess saving")
                }
            }
        }
        tableView.reloadData()
        messageTF.text = ""
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath) as! MessageCell

        cell.label.text = messages[indexPath.row].body
        //cell.rightAvatar.image = UIImage(named: <#T##String#>)
        return cell
    }
    
}
