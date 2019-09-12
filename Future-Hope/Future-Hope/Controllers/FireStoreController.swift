//
//  FireStoreController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/27/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation
import Firebase



struct FireStoreController {
    
	static let users = "users"
    static let meetings = "meetings"
    static let db = Firestore.firestore()
    
    var usersColectionRef: CollectionReference {
        return FireStoreController.db.collection(FireStoreController.users)
    }
    
    var meetingsCollectionRef: CollectionReference {
        return FireStoreController.db.collection(FireStoreController.meetings)
    }
    
    
	func addUser(with user: CurrentUser, completion: @escaping (Error?) -> ()) {
        usersColectionRef.document(user.uid).setData(user.toDictionary) { error in
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
		}
	}
    
    func fetchAllUsers(completion: @escaping ([CurrentUser]?, Error?) -> ()){
        usersColectionRef.getDocuments { documentsSnapShot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let snap = documentsSnapShot else { return }
            
            var users: [CurrentUser] = []
            for document in snap.documents {
                let dict = document.data() as [String: Any]
                if let user = CurrentUser(dictionary: dict) {
                    users.append(user)
                }
            }
            
            completion(users, nil)
        }
    }
    
    func fetchMeetings(completion: @escaping ([Meeting]?, Error?) -> ()) {
       meetingsCollectionRef.getDocuments { documentsSnapShot, error in
            if let error =  error {
                completion(nil, error)
                return
            }
            
            guard let snap = documentsSnapShot else { return }
            
            var meetings: [Meeting] = []
            for document in snap.documents {
                let dict = document.data() as [String: Any]
                
                if let meeting = Meeting(dictionary: dict) {
                    meetings.append(meeting)
                }
            }
            
            completion(meetings, nil)
        }
    }
    
    func fetchMeeting(with uid: String, completion: @escaping (Meeting?, Error?) -> ()) {
       meetingsCollectionRef.document(uid).getDocument { documentSnapShot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let doc = documentSnapShot,
                let data = doc.data() else { return }
            
            let dict = data as [String: Any]
            if let meeting = Meeting(dictionary: dict) {
                completion(meeting, nil)
            }
        }
    }
    
    
    func fetchAllTeachers(completion: @escaping ([CurrentUser]?, Error?) -> ()) {
        let whereField =  meetingsCollectionRef.whereField("userType", isGreaterThan: "teacher")
        whereField.getDocuments { documentsSnapShot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let documents = documentsSnapShot else { return }
            print(documents.count)
            
            
            
            
        }
        
        
        
    }
    
    
    
    
}
