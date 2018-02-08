//
//  ReadingDetailsViewController.swift
//  PagePlaner
//
//  Created by Tia King on 1/14/18.
//  Copyright © 2018 Tia King. All rights reserved.
//

import UIKit
extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
class ReadingDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1 {
            return 1
        }
        
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 20.0
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 30.0
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
                hoursGoalPicker.subviews[0].subviews[1].isHidden = true
                hoursGoalPicker.subviews[0].subviews[2].isHidden = true
        }
        
        return nil
    }
    
   
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var dateBackground: UIImageView!
    @IBOutlet weak var hoursBackground: UIImageView!

    @IBOutlet weak var saveDetailsButton: UIButton!
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
        numOfPagesTextField.keyboardType = UIKeyboardType.numberPad
        numKeypadToolbar.sizeToFit()
        numKeypadToolbar.tintColor = UIColor.gray
        numKeypadToolbar.isTranslucent = true
        // add a toolbar with a done button above the number pad
        
        //proper num keyboard pops up, but still have to implement
        //checks to ensure user cannot type non numerical numbers
    }
    
    @IBOutlet weak var numOfPagesTextField: UITextField!
    
    @IBOutlet weak var currentDateTextField: UITextField!
    
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        dateBackground.layer.borderWidth = 0.35
        dateBackground.layer.borderColor = UIColor.gray.cgColor
        
        hoursBackground.layer.borderWidth = 0.35
        hoursBackground.layer.borderColor = UIColor.gray.cgColor
        //does not allow users to choose goal dates that have already passed
        datePicker.minimumDate = Date()
        
        

        
        
        //customizing UILabels
        let newColor = UIColor.black.cgColor
//       
        //adding data from array to UIPickers
        hoursGoalPicker.dataSource = self
        hoursGoalPicker.delegate = self
        
        let hoursGoalPickerColor = UIColor(red: 74.5/255.0 , green: 88.5/255.0, blue: 210.5/255.0, alpha: 0.5)
        hoursGoalPicker.backgroundColor = UIColor.clear
        //hoursGoalPicker.layer.borderColor = UIColor.black as! CGColor
        hoursGoalPicker.layer.borderWidth = 0.5
        
        
        
        //calling done buttons on keyboard functions
        addDoneButtononKeyboard(textField: titleTextField)
        addDoneButtonOnNumpad(textField: numOfPagesTextField)
        
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

    }
    
    func createDatePicker() {
        
        datePicker.datePickerMode = .date
        self.datePicker.minimumDate = Date()
       
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
        
        /*
         Formatting the dateDifference calculated String to include only the month and day
         numerical difference. Saves those to integers to different variables for
         easier future calculations.
         */
//        if let string = formatter.string(from: startDate, to: endDate) {
//            let intString = string.components(
//                separatedBy: NSCharacterSet
//                    .decimalDigits
//                    .inverted)
//                .joined(separator: " ")
//
//            let trimmedString = intString.removingWhitespaces()
//            print(trimmedString)
//
//            let startindex = trimmedString.characters.index(trimmedString.startIndex, offsetBy: 0)
//            let monthAmount = trimmedString[startindex]
//            print(monthAmount)
//
//            let endindex = trimmedString.characters.index(trimmedString.startIndex, offsetBy: 1)
//            let editedDayAmount = trimmedString[endindex]
//            let dayAmount = Int(String(editedDayAmount))!
//
//            let monthToDays = (Int(String(monthAmount)))!*30
//            print(monthToDays)
//
//            let totalDayAmount = monthToDays + dayAmount
//            print(totalDayAmount)
//
//            let readingTime = Double(timeElapsed)! * Double(numOfPagesTextField.text!)!
//            let perDay = (readingTime/Double(totalDayAmount))
//            print(perDay)
//
//            } else {
//                print("error")
//        }
//
//
   }
//
    
}


