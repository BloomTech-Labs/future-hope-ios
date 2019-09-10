//
//  MyScdualTableViewCell.swift
//  Future-Hope
//
//  Created by Hector Steven on 9/5/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class MyScdualTableViewCell: UITableViewCell {
	
	var meeting: Meeting? {
		didSet { setupViews() }
	}
	
	@IBOutlet var userImageView: UIImageView!
	@IBOutlet var timeLabel: UILabel!
	@IBOutlet var meetingTitle: UILabel!
	
	private func setupViews() {
        
        guard let meeting = meeting else { return }
        
        meetingTitle?.text = meeting.title

        // setup Date
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        timeLabel?.text = format.string(from: meeting.start)
        
        
        // get first user image
        
	}
    
    

    
}
