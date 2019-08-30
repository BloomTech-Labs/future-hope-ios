//
//  MainViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/29/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//
import UIKit


extension ProfileSettingsViewController: FutureHopSchoolControllerProtocol {}

class ProfileSettingsViewController: UIViewController {
	var futureHopSchoolController: ApplicationController?
	
	private let settings = ["About Me", "city", "country","email", "phone number", "State/Province"]
	var currentSignedInUser: CurrentUser?
	
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var namelabel: UILabel!
	@IBOutlet var userTypeLabel: UILabel!
	@IBOutlet var tableView: UITableView!
	@IBOutlet var aboutMeTextView: UITextView!
	@IBOutlet var statusLabel: UILabel!
	
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
		guard let user = futureHopSchoolController?.fetchCurrentAuthenticatedUser() else { return }
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
		
		futureHopSchoolController?.setCurrentUser(with: currentSignedInUser)
		
		imageView.layer.cornerRadius = 10
		
		namelabel?.text = currentSignedInUser.fullName
		statusLabel?.text = currentSignedInUser.awaitingApproval == true ? "awaiting approval" : "Approved"
		userTypeLabel?.text = currentSignedInUser.userType == .mentor ? "mentor" : "teacher"
		
		aboutMeTextView?.text = currentSignedInUser.aboutMe
		aboutMeTextView.layer.borderWidth = 1
		aboutMeTextView.layer.cornerRadius = 4
		
		
		futureHopSchoolController?.fetchUserImage(with: currentSignedInUser.photoUrl) { data, error in
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


extension ProfileSettingsViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return section == 0 ?  "Edit Your Profile" : "Log out"
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return section == 0 ? settings.count : 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "dashBoardCell", for: indexPath)
		
		if indexPath.section == 0 {
			cell.textLabel?.text = settings[indexPath.row]
		} else {
			cell.textLabel?.text = "SingOut"
		}
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 0 {
			
			if indexPath.row == 0 {
				
			}
			
			
		} else if indexPath.section == 1 {
			if indexPath.row == 0 {
				
				let ac = UIAlertController(title: "SignOut?", message: nil, preferredStyle: .actionSheet)
				
				ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
					self.signOutWithFireStore()
				}))

				ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
				
				present(ac, animated: true)
				
			}
		}
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
	
	
	private func signOutWithFireStore() {
		print("sign out")
	}
	
}
