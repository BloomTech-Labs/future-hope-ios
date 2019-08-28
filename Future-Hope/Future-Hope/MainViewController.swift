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
	
	@IBOutlet var nameTextField: UITextField!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		
		
    }

	private func setupViews() {
		// set user
		guard let currentSignedInUser = currentSignedInUser else { return }
		
		futureHopeController.setCurrentUser(with: currentSignedInUser)
		
		// setup view
	
		
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
