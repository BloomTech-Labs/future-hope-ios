//
//  ExploreTableViewCell.swift
//  Future-Hope
//
//  Created by SL Hector Villasano on 9/11/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit




class ExploreTableViewCell: UITableViewCell {

    var currentUser: CurrentUser? {
        didSet { setupViews() }
    }
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    private func setupViews(){
        guard let currentUser =  currentUser else { return }
        
        nameLabel?.text = currentUser.fullName
        if let type = currentUser.userType {
            let str: String = type == .mentor ? "Mentor" : "Teacher"
            typeLabel?.text = str
        }
        
        setupImage()
    }
    
    private func setupImage() {
        guard let user = currentUser, let url = user.photoUrl else { return }
        ApplicationController().fetchUserImage(with: url) { data, error in
            if let error = error {
                NSLog("Error wiht applicationcontroller: \(error)")
                return
            }
            guard let data = data else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.userImageView?.image = image
            }
            
        }
    }
}
