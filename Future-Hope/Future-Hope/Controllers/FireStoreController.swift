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
    
//    func fetchAllUsers(completion: @escaping ([CurrentUser]?, Error?) -> ()){
//        usersColectionRef.getDocuments { documentsSnapShot, error in
//            if let error = error {
//                completion(nil, error)
//                return
//            }
//
//            guard let snap = documentsSnapShot else { return }
//
//            var users: [CurrentUser] = []
//            for document in snap.documents {
//                let dict = document.data() as [String: Any]
//                if let user = CurrentUser(dictionary: dict) {
//                    users.append(user)
//                }
//            }
//
//            completion(users, nil)
//        }
//    }
    
//    func fetchMeetings(completion: @escaping ([Meeting]?, Error?) -> ()) {
//       meetingsCollectionRef.getDocuments { documentsSnapShot, error in
//            if let error =  error {
//                completion(nil, error)
//                return
//            }
//
//            guard let snap = documentsSnapShot else { return }
//
//            var meetings: [Meeting] = []
//            for document in snap.documents {
//                let dict = document.data() as [String: Any]
//
//                if let meeting = Meeting(dictionary: dict) {
//                    meetings.append(meeting)
//                }
//            }
//
//            completion(meetings, nil)
//        }
//    }
//
//    func fetchMeeting(with uid: String, completion: @escaping (Meeting?, Error?) -> ()) {
//       meetingsCollectionRef.document(uid).getDocument { documentSnapShot, error in
//            if let error = error {
//                completion(nil, error)
//                return
//            }
//
//            guard let doc = documentSnapShot,
//                let data = doc.data() else { return }
//
//            let dict = data as [String: Any]
//            if let meeting = Meeting(dictionary: dict) {
//                completion(meeting, nil)
//            }
//        }
//    }
//
    // MARK:
    func fetchAllTeachers(completion: @escaping ([CurrentUser]?, Error?) -> ()) {
        let whereField =  usersColectionRef.whereField("userType", isEqualTo: "teacher")
        whereField.getDocuments { documentsSnapShot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let documents = documentsSnapShot else { return }
            print(documents.count)
            var users: [CurrentUser] = []
            for doc in documents.documents {
                let dictioanary = doc.data() as [String: Any]
                if let user = CurrentUser(dictionary: dictioanary) {
                    users.append(user)
                }
            }
            
            completion(users, nil)
        }
    }
    
    
    func fetchMyMeetings(with uid: String, completion: @escaping ([Meeting]?, Error?) -> ()) {
        
        
        let whereField = meetingsCollectionRef.whereField("participantUIDs", arrayContains: uid)
        
        whereField.getDocuments { meetingsSnapShot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let meetings = meetingsSnapShot else { return }
            
            var myMeetings: [Meeting] = []
            for meeting in meetings.documents {
                let dictioanry = meeting.data() as [String: Any]
                
                if let meeting = Meeting(dictionary: dictioanry) {
                    myMeetings.append(meeting)
                }
            }
            
            completion(myMeetings, nil)
        }
    }
    
    
    
}
