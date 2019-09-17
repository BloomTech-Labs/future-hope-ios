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

    func fetchAllTeachers(completion: @escaping ([CurrentUser]?, Error?) -> ()) {
        let whereField =  usersColectionRef.whereField("userType", isEqualTo: "teacher")
        whereField.getDocuments { documentsSnapShot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let documents = documentsSnapShot else { return }
            
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
    
    // MARK: Meetins
    
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
    
    func checkIfmeetingExist(currentUser: CurrentUser, timestamp: Timestamp, completion: @escaping (Meeting?, Error?) -> ()) {
        let whereField = meetingsCollectionRef.whereField("participantUIDs", isEqualTo: currentUser.uid).whereField("start", isEqualTo: timestamp)
        whereField.getDocuments { snapShot, error in
            if let error = error{
                completion(nil, error)
                return
            }
            guard let snapShot = snapShot else { return }
            print(snapShot.documents.count)
            let dict = snapShot.documents[0].data() as [String: Any]
            guard let meeting = Meeting(dictionary: dict) else { return }
            completion(meeting, nil)
            
    
            
        }
    }
    
    func addMeeting(with meeting: Meeting, completion: @escaping (Error?) -> ()) {
        

        meetingsCollectionRef.document(meeting.id).setData(meeting.toDictionary) { error in
            if let error = error {
                completion(error)
                return
            }

            completion(nil)
        }
        

        
    }
}
