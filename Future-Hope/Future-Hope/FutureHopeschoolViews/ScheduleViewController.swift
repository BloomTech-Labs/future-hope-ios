//
//  ScheduleViewController.swift
//  Future-Hope
//
//  Created by HSV on 9/15/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

extension ScheduleViewController: FutureHopSchoolControllerProtocol {}

class ScheduleViewController: UIViewController {
    var futureHopSchoolController: ApplicationController?
    var user: CurrentUser?
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var aboutMeTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
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
        
        let str = futureHopSchoolController?.format.string(from: Date())
        startDateLabel?.text = str
        
        
    }
    

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let date = sender.date
        let str = futureHopSchoolController?.format.string(from: date)
        startDateLabel?.text = str
    }
    
   
    
    @IBAction func scheduleMeetingButtonPressed(_ sender: Any) {
        guard let user = user else { return }
        let date = futureHopSchoolController!.format.string(from: datePicker.date)
        let alertController = UIAlertController(title: "With \(user.fullName)\n\(date)", message: "Set a title:", preferredStyle: .alert)
        alertController.addTextField{ textField in
            textField.placeholder = "Meeting Title"
        }
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            if let title = alertController.textFields?[0].text {
            
                // create it in the app controller
                self.createNewMeeting(with: title)
                print(title)
                
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        present(alertController, animated: true)
        
    }
    
    private func createNewMeeting(with title: String) {
        
        guard let currentUser = futureHopSchoolController?.currentlyLogedInUser, let user = user else { return }
        let participantName: [String] = [currentUser.fullName, user.fullName]
        let participantUIDs: [String] = [currentUser.uid, user.uid]

        let id = FireStoreController().meetingsCollectionRef.document().documentID
        
        let meeting = Meeting(id: id, participantNames: participantName, participantUIDs: participantUIDs, start: datePicker.date, title: title)
        futureHopSchoolController?.addMeetingToFirebase(with: meeting, completion: { error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            self.dismiss(animated: true)
        })
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
