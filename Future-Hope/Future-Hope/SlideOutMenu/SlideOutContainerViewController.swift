//
//  SlideOutContainerViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/27/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class SlideOutContainerViewController: UIViewController {

	enum SlideOutState {
		case panelCollapsed
		case panelExpanded
	}
	
	var mainNavigationController: UINavigationController!
	var mainViewController: MainViewController!
	
	var curentState: SlideOutState = .panelCollapsed {
		didSet {
			let shouldShowShadow = curentState
			//showShadowForCCeneterViewController(ShouldShowShadow)
		}
	}
	
	var rightViewController: SlideOutMenuViewController?
	
	let centerPanelExpandedOffset: CGFloat = 90
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	
	
	
	
}
