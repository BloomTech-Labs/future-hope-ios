//
//  FetchPhotoOperation.swift
//  Future-Hope
//
//  Created by HSV on 9/17/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

class FetchPhotoOperation: ConcurrentOperation {
    let userImageUrl: String
    var imageData: Data?
    private var task: URLSessionDataTask?
    
    
    override func cancel() {
        task?.cancel()
    }
    
    init(userImageUrl: String) {
        self.userImageUrl = userImageUrl
    }
    
    override func start() {
        state = .isExecuting
        guard let url = URL(string: userImageUrl) else { return }
        
        task = URLSession.shared.dataTask(with: url){ data, _, error in
            if let error = error {
                print("Error fetching image: \(error)")
                return
            }
            
            guard let data = data else { return }
            self.imageData = data
            //do or defer
            do {self.state = .isFinished}
        }
        
        task?.resume()
    }
    
   
}
