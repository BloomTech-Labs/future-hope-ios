//
//  AppDelegate.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/15/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		FirebaseApp.configure()
		return true
	}



}

