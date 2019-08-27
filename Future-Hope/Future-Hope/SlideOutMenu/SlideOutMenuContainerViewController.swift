//
//  SlideOutMenuContainerViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/26/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

protocol SlideOutMenuContainerViewControllerDelegate{
	func didSelectIndex(_ indexPath: IndexPath)
}


class SlideOutMenuContainerViewController: UIViewController {

	
	@IBOutlet var tableView: UITableView!
	
	var delegate: SlideOutMenuContainerViewControllerDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
    }


}


extension SlideOutMenuContainerViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SlideOutCell", for: indexPath)
		return cell
	}
	
	
	
}


extension SlideOutMenuContainerViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.didSelectIndex(indexPath)
	}
}
