//
//  EmailSignUpViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialButtons

class EmailSignUpViewController: UIViewController {

	
	@IBOutlet var fullNameTextField: MDCTextField!
	@IBOutlet var emailTextFields: MDCTextField!
	@IBOutlet var passwordTextField: MDCTextField!
	@IBOutlet var confirmPasswordTextField: MDCTextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	@IBAction func submitButtonPressed(_ sender: MDCButton) {
		//submit to auth
	}
	
	
	@IBAction func cancelButtonPressed(_ sender: MDCButton) {
		navigationController?.popViewController(animated: true)
	}
	
}
