//
//  MyScdualTableViewCell.swift
//  Future-Hope
//
//  Created by Hector Steven on 9/5/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class MyScdualTableViewCell: UITableViewCell {
	
	var currentUser: CurrentUser? {
		didSet {setupViews()}
	}
	
	@IBOutlet var userImageView: UIImageView!
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var aboutMeTextView: UITextView!
	@IBOutlet var timeLabel: UILabel!
	
	private func setupViews() {
		guard let user = currentUser, let data = user.imageData else { return }
		userImageView?.image = UIImage(data: data)
		nameLabel?.text = user.fullName
		aboutMeTextView?.text = user.aboutMe
		timeLabel.text = "10:00 Am Tuesday???"

	}
	
	
}
