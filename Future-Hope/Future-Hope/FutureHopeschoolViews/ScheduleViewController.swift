//
//  ScheduleViewController.swift
//  Future-Hope
//
//  Created by HSV on 9/15/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

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
    }
    

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let date = sender.date
        let format = DateFormatter()
        format.calendar = .current
        format.dateStyle = .long
        let str = format.string(from: date)
        startDateLabel?.text = str
        print(str)
        
    }
    
    @IBAction func scheduleMeetingButtonPressed(_ sender: Any) {
        
        
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
