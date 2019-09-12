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

	private let settings = ["name", "city", "state", "phone number","about me", "FAQs"]
	
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
		setupViews()
	}
	
	private func setupViews() {
		guard let currentSignedInUser = futureHopSchoolController?.currentlyLogedInUser else { return }
		
		if let data = currentSignedInUser.imageData {
			imageView.image = UIImage(data: data)
		}
		
		imageView.layer.cornerRadius = 10
		
		namelabel?.text = currentSignedInUser.fullName
		statusLabel?.text = currentSignedInUser.awaitingApproval == true ? "awaiting approval" : "Approved"
		userTypeLabel?.text = currentSignedInUser.userType == .mentor ? "mentor" : "teacher"
		
		aboutMeTextView?.text = currentSignedInUser.aboutMe
		aboutMeTextView.layer.borderWidth = 1
		aboutMeTextView.layer.cornerRadius = 4
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "UpdateUserInformationSegue" {
			guard let vc = segue.destination as? EditProfileViewController,
				let indexpath = tableView.indexPathForSelectedRow else { return }
			
			vc.editString = settings[indexpath.row]
			vc.currentUser = futureHopSchoolController?.currentlyLogedInUser
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
			if indexPath.row >= 0 && indexPath.row <= settings.count - 2 {
				performSegue(withIdentifier: "UpdateUserInformationSegue", sender: self)
			}else if indexPath.row == settings.count - 1 {
				
				// No exit
				//performSegue(withIdentifier: "FAQsSegue", sender: self)
			}
		} else if indexPath.section == 1 {
			if indexPath.row == 0 {
				self.signOutWithFireStore()
				
			}
		}
	}
	
	
	private func getUserData(with row: Int) -> String? {
		guard let user = futureHopSchoolController?.currentlyLogedInUser  else { return nil }
		
		if row == 0 {
			return "edit"
		} else if row == 1 {
			return user.awaitingApproval == true ? "awaiting approval" : "approved"
		} else if row == 2 {
			return user.city
		} else if row == 3 {
			return user.country
		}else if row == 4 {
			return user.email
		}else if row == 5 {
			return user.phoneNumber
		}
		return nil
	}
	
	
	private func signOutWithFireStore() {
		
		let ac = UIAlertController(title: "SignOut", message: nil, preferredStyle: .actionSheet)
		ac.addAction(UIAlertAction(title: "Ok", style: .default){ _ in
			self.futureHopSchoolController?.signOut{ error in
				if let error = error {
					NSLog("Error Signing out: \(error)")
					return
				}
				
				DispatchQueue.main.async {
					self.gooToMainView()
				}
				
			}
		})

		ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
		present(ac, animated: true)
	}
	
	private func gooToMainView() {
		guard let homeVC = storyboard?.instantiateViewController(withIdentifier: "SignInMainVC") as? UINavigationController else {
			print("homeVC was not found!")
			return
		}
		
		view.window?.rootViewController = homeVC
		view.window?.makeKeyAndVisible()
	}
	
	
	
}
