//
//  AddAlertViewController.swift
//  DrinkAlarm
//
//  Created by Mac on 2022/01/24.
//

import UIKit

class AddAlertViewController: UIViewController {
    var pickedDate: ((_ date: Date) -> Void)?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func tapDismissButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSaveButton(_ sender: UIBarButtonItem) {
        pickedDate?(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
    
}
