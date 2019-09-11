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
    }
}
