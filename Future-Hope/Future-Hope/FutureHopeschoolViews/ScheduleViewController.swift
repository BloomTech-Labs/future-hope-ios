//
//  ScheduleViewController.swift
//  Future-Hope
//
//  Created by HSV on 9/15/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.minimumDate = Date()
    }
    

    
    @IBAction func sceduleMeetingButtonPressed(_ sender: Any) {
        
        
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
