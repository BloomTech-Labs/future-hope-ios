//
//  ExploreTableViewController.swift
//  Future-Hope
//
//  Created by SL Hector Villasano on 9/11/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

extension ExploreTableViewController: FutureHopSchoolControllerProtocol{}

class ExploreTableViewController: UITableViewController {
    var futureHopSchoolController: ApplicationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        futureHopSchoolController?.fetchAllUsers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return futureHopSchoolController?.allUsers.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreTableViewCell", for: indexPath)
        guard let exlporeCell = cell as? ExploreTableViewCell,
            let user = futureHopSchoolController?.allUsers[indexPath.row] else { return cell }
            exlporeCell.currentUser = user
        
        return exlporeCell
    }
    
    
    
    
}
