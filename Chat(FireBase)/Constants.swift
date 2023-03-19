//
//  Constants.swift
//  Chat(FireBase)
//
//  Created by Aleksandra Asichka on 2023-03-18.
//

struct Constants {
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let cell = "cell"
    static let cellNibName = "MessageCell"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
