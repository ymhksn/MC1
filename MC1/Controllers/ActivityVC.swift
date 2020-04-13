//
//  ActivityVC.swift
//  MC1
//
//  Created by Yohanes Markus Heksan on 13/04/20.
//  Copyright © 2020 Yohanes Markus Heksan. All rights reserved.
//

import UIKit
import CoreData

class ActivityVC: UIViewController {
    @IBOutlet weak var activityTitle: UILabel!
    
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var timeInTextField: UITextField!
    @IBOutlet weak var timeOutTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    private var timeInDatePicker: UIDatePicker?
    private var timeOutDatePicker: UIDatePicker?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

//    var selectedActivity : Category? {
//        didSet{
//            loadActivity()
//        }
//    }
    
    var selectedActivity = Category()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityTitle.text = selectedActivity.name
        
        timeInTextField.borderStyle = .none
        timeOutTextField.borderStyle = .none
        
        
        timeInDatePicker = UIDatePicker()
        timeInDatePicker?.datePickerMode = .time
        timeInDatePicker?.addTarget(self, action: #selector(ActivityVC.dateChanged(timeInDatePicker:)), for: .valueChanged)
        timeInTextField.inputView = timeInDatePicker
        
        
        timeOutDatePicker = UIDatePicker()
        timeOutDatePicker?.datePickerMode = .time
        timeOutDatePicker?.addTarget(self, action: #selector(ActivityVC.dateChanges(timeOutDatePicker:)), for: .valueChanged)
        timeOutTextField.inputView = timeOutDatePicker
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ActivityVC.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        
        noteTextView.clipsToBounds = false
        noteTextView.layer.cornerRadius = 10
        noteTextView.layer.shadowRadius = 5
        noteTextView.layer.shadowColor = UIColor.gray.cgColor
        noteTextView.layer.shadowOffset = CGSize (width: 2, height: 2)
        noteTextView.layer.shadowOpacity = 0.8
        
        // Do any additional setup after loading the view.
    }
    
    @objc func viewTapped (gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged (timeInDatePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH : mm "
        timeInTextField.text = dateFormatter.string(from: timeInDatePicker.date)
    }
    
    @objc func dateChanges (timeOutDatePicker: UIDatePicker){
        let dateFormatters = DateFormatter()
        dateFormatters.dateFormat = "HH : mm "
        timeOutTextField.text = dateFormatters.string(from: timeOutDatePicker.date)
    }
}
