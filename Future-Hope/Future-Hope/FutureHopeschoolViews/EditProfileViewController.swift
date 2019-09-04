//
//  EditProfileViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 9/4/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class EditProfileViewController: UIViewController {

	@IBOutlet var editLabel: UILabel!
	@IBOutlet var newEditTextField: MDCTextField!
	var editString: String?
	var currentUser: CurrentUser?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		setupViews()
	}
	
	private func setupViews() {
		guard let editString = editString else { return }
		editLabel?.text = "\(editString):"
	}
	
	@IBAction func exitButtonPressed(_ sender: Any) {
		dismiss(animated: true)
	}
	
	@IBAction func submitButtonPressed(_ sender: Any) {
	}
	
	
}
