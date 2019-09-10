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
	
	func addUserToFireStore(with user: CurrentUser, completion: @escaping (Error?) -> ()) {
		Firestore.firestore().collection(FireStoreController.users).document(user.uid).setData(user.toDictionary) { error in
            if let error = error {
                completion(error)
            }
            completion(nil)
		}
	}
    
    func fetchMeetingsFromFirestore(completion: @escaping ([Meeting]?, Error?) -> ()) {
        
        Firestore.firestore().collection(FireStoreController.meetings).getDocuments { snapShot, error in
            if let error =  error {
                completion(nil, error)
                return
            }
            
            guard let snap = snapShot else { return }
            let documents = snap.documents
            
            var meetings: [Meeting] = []
            
            print("meetings count: \(documents.count)")
            
            for document in documents {
                let doc = document.data() as [String: Any]
                
                if let meeting = Meeting(dictionary: doc) {
                    meetings.append(meeting)
                }
            }
            
            completion(meetings, nil)
        }
        
        
    }
}
