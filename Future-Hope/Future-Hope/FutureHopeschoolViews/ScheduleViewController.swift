//
//  ScheduleViewController.swift
//  Future-Hope
//
//  Created by HSV on 9/15/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit



class ScheduleViewController: UIViewController {
    
    var currentUser: CurrentUser?
    var user: CurrentUser?
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var aboutMeTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var format: DateFormatter {
        let format = DateFormatter()
        format.calendar = .current
        format.dateStyle = .long
        format.timeStyle = .medium
        return format
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.minimumDate = Date()
        datePicker.minuteInterval = 15
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    
    private func setupViews() {
        guard let user = user else { return }
        nameLabel?.text = user.fullName
        aboutMeTextView?.text = user.aboutMe
        
        if let data = user.imageData {
            userImageView?.image = UIImage(data: data)
        }
        
        let str = format.string(from: Date())
        startDateLabel?.text = str
        
        
    }
    

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let date = sender.date
        let str = format.string(from: date)
        startDateLabel?.text = str
    }
    
   
    
    @IBAction func scheduleMeetingButtonPressed(_ sender: Any) {
        guard let user = user else { return }
        
        let alertController = UIAlertController(title: "Meeting with \(user.fullName)  \(format.string(from: datePicker.date))", message: "Set a title:", preferredStyle: .alert)
        alertController.addTextField()
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            if let title = alertController.textFields?[0].text {
                
                // create it in the app controller
                //self.createNewMeeting(with: title)
                
                
            }
            self.dismiss(animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        present(alertController, animated: true)
        
    }
    
    private func createNewMeeting(with title: String) {
        
        guard let currentUser = currentUser, let user = user else { return }
        let participantName: [String] = [currentUser.fullName, user.fullName]
        let participantUIDs: [String] = [currentUser.uid, user.uid]

        let _ = Meeting(id: UUID().uuidString, participantNames: participantName, participantUIDs: participantUIDs, start: datePicker.date, title: title)
    }
    
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
