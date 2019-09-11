//
//  MySchedualViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 9/5/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

extension MySchedualViewController: FutureHopSchoolControllerProtocol {}

class MySchedualViewController: UIViewController {
    var futureHopSchoolController: ApplicationController?
	@IBOutlet var numberOfMettingsLabel: UILabel!
	@IBOutlet var tableView: UITableView!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        
        tableView.reloadData()
        
	}

}

extension MySchedualViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return futureHopSchoolController?.meetings.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MySchedualCell", for: indexPath)
		guard let mySchedualCell = cell as? MyScdualTableViewCell, let meetings = futureHopSchoolController?.meetings else { return cell }
		let meeting = meetings[indexPath.row]
        mySchedualCell.meeting = meeting
		return mySchedualCell
	}
	
}
