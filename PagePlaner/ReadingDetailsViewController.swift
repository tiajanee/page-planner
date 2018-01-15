//
//  ReadingDetailsViewController.swift
//  PagePlaner
//
//  Created by Tia King on 1/14/18.
//  Copyright © 2018 Tia King. All rights reserved.
//

import UIKit


class ReadingDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1 {
            return 1
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return hoursGoalPickerData.count
        }
        
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView.tag == 1 {
                return hoursGoalPickerData[row]
        }
        
        return nil
    }
   
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
  
    @IBOutlet weak var datePickerText: UITextField!
    @IBOutlet weak var hoursGoalPicker: UIPickerView!
    
    let hoursGoalPickerData = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    //adding done button regular keyboard 
    func addDoneButtononKeyboard(textField: UITextField) {
        let keyboardToolbar: UIToolbar = UIToolbar()
        keyboardToolbar.items=[
            UIBarButtonItem(title: "done", style: UIBarButtonItemStyle.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        ]
        
        keyboardToolbar.sizeToFit()
        keyboardToolbar.tintColor = UIColor.gray
        keyboardToolbar.isTranslucent = true
        // add a toolbar with a done button above the keyboard
        titleTextField.inputAccessoryView = keyboardToolbar
    }
    //adding done button to numpad keyboard
    func addDoneButtonOnNumpad(textField: UITextField) {
        
        let numKeypadToolbar: UIToolbar = UIToolbar()
        numKeypadToolbar.items=[
            UIBarButtonItem(title: "done", style: UIBarButtonItemStyle.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        ]
        
        numKeypadToolbar.sizeToFit()
        numKeypadToolbar.tintColor = UIColor.gray
        numKeypadToolbar.isTranslucent = true
        // add a toolbar with a done button above the number pad
        numOfPagesTextField.inputAccessoryView = numKeypadToolbar
    }
    
    @IBOutlet weak var numOfPagesTextField: UITextField!
    
    @IBOutlet weak var currentDateTextField: UITextField!
    
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        
        
        //customizing UILabels
        let newColor = UIColor.black.cgColor
        dateLabel.layer.backgroundColor = newColor
        dateLabel.layer.opacity = 0.40
        dateLabel.layer.borderColor = newColor
        dateLabel.layer.borderWidth = 1
        dateLabel.layer.cornerRadius = (dateLabel.bounds.width)/50
        
        hoursLabel.layer.backgroundColor = newColor
        hoursLabel.layer.opacity = 0.40
        hoursLabel.layer.borderColor = newColor
        hoursLabel.layer.borderWidth = 1
        hoursLabel.layer.cornerRadius = (hoursLabel.bounds.width)/50
        
        //adding data from array to UIPickers
        hoursGoalPicker.dataSource = self
        hoursGoalPicker.delegate = self
        
       
        
        
        //calling dismissing done buttons on keyboard functions
        addDoneButtonOnNumpad(textField: numOfPagesTextField)
        addDoneButtononKeyboard(textField: titleTextField)
        
        //setting the format to display current date
        var currentDate = String(describing: Date())
        //goalDatePicker.datePickerMode = .date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMd")
        currentDate = dateFormatter.string(from: Date())
        currentDateTextField.text = currentDate
        //let selectedDate = dateFormatter.string(from: goalDatePicker.date)
        //print(selectedDate)
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.

        
    }
    
    func createDatePicker() {
        
        datePicker.datePickerMode = .date
        self.datePicker.minimumDate = Date()
        //self.datePicker.maximumDate = DateInterval(start: Date(), dur)
       
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "done", style: UIBarButtonItemStyle.done, target: nil, action:#selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        toolbar.sizeToFit()
        toolbar.tintColor = UIColor.gray
        toolbar.isTranslucent = true
        datePickerText.inputAccessoryView = toolbar
        datePickerText.inputView = datePicker
    }
    
    @objc func donePressed() {
        
        //formatting date
        let finishDateFormatter = DateFormatter()
        finishDateFormatter.dateStyle = .medium
        finishDateFormatter.timeStyle = .none
        
        datePickerText.text = finishDateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
        let startDate = Date()
        let endDate = datePicker.date
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.month, .day]
        formatter.maximumUnitCount = 2   // often, you don't care about seconds if the elapsed time is in months, so you'll set max unit to whatever is appropriate in your case
        
        let string = formatter.string(from: startDate, to: endDate)
        print(string)
    }
    
    
}


