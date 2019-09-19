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
    var fetchPhotoOperation: [Int: FetchPhotoOperation] = [:]
    private let photoFetchQueue = OperationQueue()
    var userImageCache = Cache<Int, Data>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoFetchQueue.name = "com.LambdaSchool.Future-Hope"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return futureHopSchoolController?.teachers.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreTableViewCell", for: indexPath)
        guard let exlporeCell = cell as? ExploreTableViewCell,
            let user = futureHopSchoolController?.teachers[indexPath.row] else { return cell }
        
        exlporeCell.currentUser = user
        loadImage(with: exlporeCell, indexPath: indexPath)
        
        return exlporeCell
    }
    
    private func loadImage(with cell: ExploreTableViewCell, indexPath: IndexPath){
        guard let user = futureHopSchoolController?.teachers[indexPath.row], let url = user.photoUrl else { return }
        
        if let imageData = userImageCache.value(for: indexPath.row) {
            cell.userImageView?.image = UIImage(data: imageData)
        }
        
        let fetchOp = FetchPhotoOperation(userImageUrl: url.absoluteString)
        
        let storeToCache = BlockOperation {
            if let imageData = fetchOp.imageData {
                self.userImageCache.cache(value: imageData, for: indexPath.row)
            }
        }
        
        let cellReUsedCheck = BlockOperation {
            if self.tableView.indexPath(for: cell) == indexPath {
                guard let imageData = fetchOp.imageData else { return }
                cell.userImageView.image = UIImage(data: imageData)
            }
        }
        
        storeToCache.addDependency(fetchOp)
        cellReUsedCheck.addDependency(fetchOp)
        
        photoFetchQueue.addOperations([fetchOp, storeToCache], waitUntilFinished: false)
        OperationQueue.main.addOperation(cellReUsedCheck)
        fetchPhotoOperation[indexPath.row] = fetchOp
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        fetchPhotoOperation[indexPath.row]?.cancel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SchedualMeetingSegue" {
            guard let vc = segue.destination as? ScheduleViewController,
                  let indexPath = tableView.indexPathForSelectedRow,
                  let user = futureHopSchoolController?.teachers[indexPath.row]  else { return }
            
            
            if user.imageData == nil, let imageData = userImageCache.value(for: indexPath.row) {
                user.imageData = imageData
            }
            
            vc.user = user
            vc.futureHopSchoolController = futureHopSchoolController
        }
    }
    
}
