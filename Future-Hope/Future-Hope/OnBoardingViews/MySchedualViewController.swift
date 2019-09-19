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
    var myMeetings: [Meeting] = []
    var upcomingMeetings: [Meeting] = []
	
	override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        center.requestAuthorization(options: [.sound, .badge, .alert]) { _, error in
            if let error = error {
                print("error: \(error)")
                return
            }
        }
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        notifyWhenmeetingsDownloaded()
        reloadformeetings()
	}

    private func notifyWhenmeetingsDownloaded() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadformeetings), name: NSNotification.Name.init("MeetingsDownLoaded"), object: nil)
    }
    
    @objc func reloadformeetings () {
        myMeetings = futureHopSchoolController!.meetingsAfterToday
        upcomingMeetings = futureHopSchoolController!.upcomingSchedule
        if upcomingMeetings.count > 0 {
            todayScheduleNotification(meeting: upcomingMeetings[0])
        }
        numberOfMettingsLabel.text = "\(myMeetings.count + upcomingMeetings.count) Meetings"
        tableView.reloadData()
    }
    
    private func todayScheduleNotification(meeting: Meeting) {
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        
        content.title = "\(meeting.title)"
        content.body = "in 5 minutes"
        
        let dateComponents = Calendar.current.dateComponents([.month, .day, .hour, .minute, .second], from: meeting.start)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
//    private func todayScheduleNotification() {
//        let content = UNMutableNotificationContent()
//        content.sound = UNNotificationSound.default
//
//        content.title = "title"
//        content.body = "in 5 minutes"
//        content.badge = 1
//        let dateComponents = Calendar.current.dateComponents([.month, .day, .hour, .minute, .second], from: Date().addingTimeInterval(10))
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        center.add(request)
//    }
    
    
}

extension MySchedualViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if upcomingMeetings.count >= 1 {
            return 2
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if upcomingMeetings.count >= 1 {
            if section == 0 {
                return "Upcoming Schedule"
            } else if section == 1 {
                return "My Schedule"
            }
        }
        
        return nil
    }
    
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if upcomingMeetings.count >= 1 {
            if section == 0 {
                return upcomingMeetings.count
            }else if section == 1 {
                return myMeetings.count
            }
        
        }
        
        return myMeetings.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MySchedualCell", for: indexPath)
		guard let mySchedualCell = cell as? MyScdualTableViewCell else { return cell }
		
        if upcomingMeetings.count > 0  && indexPath.section == 0{
            let meeting = upcomingMeetings[indexPath.row]
            mySchedualCell.meeting = meeting
        } else {
            let meeting = myMeetings[indexPath.row]
            mySchedualCell.meeting = meeting
        }
        
        return mySchedualCell
	}
}
