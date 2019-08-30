//
//  TabBarViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/29/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

protocol FutureHopSchoolControllerProtocol: AnyObject {
	var futureHopSchoolController: ApplicationController? { set get }
}


class TabBarViewController: UITabBarController {
	
	let futureHopSchoolController = ApplicationController()
	

    override func viewDidLoad() {
        super.viewDidLoad()

		for childVC in children {
			if let vc = childVC as? FutureHopSchoolControllerProtocol {
				vc.futureHopSchoolController = futureHopSchoolController
			}
		}
		
    }

}
