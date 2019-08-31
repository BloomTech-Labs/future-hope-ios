//
//  SimpleFactsTableViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/30/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class SimpleFactsTableViewController: UITableViewController {
	let faqStrings = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse malesuada lacus ex, sit amet blandit leo lobortis eget.",
					  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse malesuada lacus ex, sit amet blandit leo lobortis eget.",
					  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse malesuada lacus ex, sit amet blandit leo lobortis eget.",
					  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse malesuada lacus ex, sit amet blandit leo lobortis eget."]
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	@objc func exitButton() {
		navigationController?.popViewController(animated: true)
	}
	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqStrings.count
    }

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "FaQCell", for: indexPath)
		cell.textLabel?.text = "FAQ\(indexPath.row + 1)"
		cell.detailTextLabel?.text = faqStrings[indexPath.row]
		return cell
	}

}
