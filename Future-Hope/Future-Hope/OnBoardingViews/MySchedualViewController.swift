//
//  MySchedualViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 9/5/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import UserNotifications

extension MySchedualViewController: FutureHopSchoolControllerProtocol {}

class MySchedualViewController: UIViewController {
    let center = UNUserNotificationCenter.current()
    
    var futureHopSchoolController: ApplicationController? 
	@IBOutlet var numberOfMettingsLabel: UILabel!
	@IBOutlet var tableView: UITableView!
    var myMeetings: [Meeting]?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
        todayScheduleNotification(center: center)
        
        
//        let handle = FireStoreController().meetingsCollectionRef.addSnapshotListener { (snapShot, error) in
//            
//        }
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        notifyWhenmeetingsDownloaded()
        reloadformeetings()
        
//        numberOfMettingsLabel.text = "\(self.futureHopSchoolController!.meetings.count) Meetings"
        tableView.reloadData()
	}

    private func notifyWhenmeetingsDownloaded() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadformeetings), name: NSNotification.Name.init("MeetingsDownLoaded"), object: nil)
    }
    
    @objc func reloadformeetings () {
        
        myMeetings = futureHopSchoolController?.meetingsSorted
        
        numberOfMettingsLabel.text = "\(self.futureHopSchoolController!.meetings.count) Meetings"
        tableView.reloadData()
    }
    
    
    private func todayScheduleNotification(center:  UNUserNotificationCenter) {
        
        center.requestAuthorization(options: [.sound, .alert]) { _, error in
            if let error = error {
                print("error: \(error)")
                return
            }
        }
        
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = "title"
        content.body = "body"
        
        let dateComponents = Calendar.current.dateComponents([.month, .day, .hour, .minute, .second], from: Date().addingTimeInterval(10))
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuid = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("\(error)")
            }
            print("notify")
        }
        
    }
    
    
}

extension MySchedualViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return futureHopSchoolController?.meetings.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MySchedualCell", for: indexPath)
		guard let mySchedualCell = cell as? MyScdualTableViewCell, let meetings = myMeetings else { return cell }
		let meeting = meetings[indexPath.row]
        mySchedualCell.meeting = meeting
		return mySchedualCell
	}
}
