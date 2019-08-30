//
//  MainViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/26/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
	private let settings = ["About Me", "Account Status", "city", "country","email", "phone number", "State/Province"]
	var currentSignedInUser: CurrentUser?
	let futureHopeController = ApplicationController()
	
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var namelabel: UILabel!
	@IBOutlet var emailLabel: UILabel!
	@IBOutlet var userTypeLabel: UILabel!
	@IBOutlet var tableView: UITableView!
	@IBOutlet var aboutMeTextView: UITextView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		fetchCurrentAuthUser()
	}
	
	private func fetchCurrentAuthUser() {
		guard let user = futureHopeController.fetchCurrentAuthenticatedUser() else { return }
		FireStoreController().fetchUser(uuid: user.uid) { user, error in
			if let error = error {
				NSLog("Error: \(error)")
				return
			}
			self.currentSignedInUser = user
			self.setupViews()
		}
	}
	
	
	private func setupViews() {
		guard let currentSignedInUser = currentSignedInUser else { return }
		
		futureHopeController.setCurrentUser(with: currentSignedInUser)
		
		namelabel?.text = currentSignedInUser.fullName
		emailLabel?.text = currentSignedInUser.email
		userTypeLabel?.text = currentSignedInUser.userType == .mentor ? "mentor" : "teacher"
		aboutMeTextView?.text = currentSignedInUser.aboutMe
		
		futureHopeController.fetchUserImage(with: currentSignedInUser.photoUrl) { data, error in
			if let error = error {
				NSLog("Error fetching user image: \(error)")
				return
			}
			
			guard let data = data else { return }
			
			DispatchQueue.main.async {
				self.imageView.image = UIImage(data: data)				
			}
		}
	}

}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return settings.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "dashBoardCell", for: indexPath)
		cell.textLabel?.text = settings[indexPath.row]
		cell.detailTextLabel?.text = getUserData(with: indexPath.row)
		return cell
	}
	
	
	
	private func getUserData(with row: Int) -> String? {
		guard let currentSignedInUser = currentSignedInUser else { return nil }
		if row == 0 {
			return "edit"
		} else if row == 1 {
			return currentSignedInUser.awaitingApproval == true ? "awaiting approval" : "approved"
		} else if row == 2 {
			return currentSignedInUser.city
		} else if row == 3 {
			return currentSignedInUser.country
		}else if row == 4 {
			return currentSignedInUser.email
		}else if row == 5 {
			return currentSignedInUser.phoneNumber
		}
		
		
		
		
		return nil
	
	}
	
	
	
	
}

