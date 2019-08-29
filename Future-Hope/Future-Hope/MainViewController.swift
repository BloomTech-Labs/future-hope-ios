//
//  MainViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/26/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

	var currentSignedInUser: CurrentUser?
	let futureHopeController = ApplicationController()
	
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var namelabel: UILabel!
	@IBOutlet var emailLabel: UILabel!
	@IBOutlet var userTypeLabel: UILabel!
	
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		
		
    }

	private func setupViews() {
		guard let currentSignedInUser = currentSignedInUser else { return }
		futureHopeController.setCurrentUser(with: currentSignedInUser)
		
		namelabel?.text = currentSignedInUser.fullName
		emailLabel?.text = currentSignedInUser.email
		userTypeLabel?.text = currentSignedInUser.userType == .mentor ? "mentor" : "teacher"
		
		
		
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	@IBAction func SldieOutMenuButtonPressed(_ sender: Any) {
		print("Slide out!")

	}

}


//protocol ToggleSlideOutMenuDelegate {
//	func toggleSlideOutMenu()
//	func collapseSidePanels()
//}
//
//class MainViewController: UIViewController {
//
//	var delegate: ToggleSlideOutMenuDelegate?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//
//	@IBAction func SldieOutMenuButtonPressed(_ sender: Any) {
//		print("Slide out!")
//
//	}
//
//}
