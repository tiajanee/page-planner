//
//  ReadingDetailsViewController.swift
//  PagePlaner
//
//  Created by Tia King on 1/14/18.
//  Copyright © 2018 Tia King. All rights reserved.
//

import UIKit
import CoreData
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

    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200.0
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
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
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
            //color the label's background
            let hue = CGFloat(row)/CGFloat(hoursGoalPickerData.count)
            pickerLabel?.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 0.50)
        }
        let titleData = hoursGoalPickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "Courier New", size: 30.0)!,NSAttributedStringKey.foregroundColor:UIColor.white])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .center
        return pickerLabel!
        
    }
   
   
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var dateBackground: UIImageView!
    @IBOutlet weak var hoursBackground: UIImageView!
    @IBOutlet weak var datePickerText: UITextField!
    @IBOutlet weak var hoursGoalPicker: UIPickerView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var numOfPagesTextField: UITextField!
    @IBOutlet weak var currentDateTextField: UITextField!
    let hoursGoalPickerData = ["1", "2", "3", "4", "5", "6", "7", "8"]

    @IBAction func finalDonePressed(_ sender: Any) {
        calculatePlan()
        finalDonePressed()
    }
    var managedObjectContext:NSManagedObjectContext!
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        hoursGoalPicker.backgroundColor = UIColor.black
        hoursGoalPicker.layer.borderWidth = 0.35
        hoursGoalPicker.layer.borderColor = UIColor.white.cgColor
        
        
        self.navigationItem.title = "PLAN"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "LibreBarcode39Text-Regular", size: 40)!]

        dateBackground.layer.borderWidth = 0.35
        dateBackground.layer.borderColor = UIColor.gray.cgColor
        
        hoursBackground.layer.borderWidth = 0.35
        hoursBackground.layer.borderColor = UIColor.gray.cgColor
        //does not allow users to choose goal dates that have already passed
        datePicker.minimumDate = Date()
        
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
            let done = UIBarButtonItem(title: "done", style: UIBarButtonItemStyle.done, target: textField, action: #selector(UITextField.resignFirstResponder))
            let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
            numKeypadToolbar.items=[done, flexible]
            numKeypadToolbar.sizeToFit()
            numKeypadToolbar.tintColor = UIColor.gray
            numKeypadToolbar.isTranslucent = true
            // add a toolbar with a done button above the number pad
            
            numOfPagesTextField.inputAccessoryView = numKeypadToolbar
            
            //proper num keyboard pops up, but still have to implement
            //checks to ensure user cannot type non numerical numbers
            
            //customizing the UILabels in the calculation section
            hoursBackground.layer.shadowColor =  UIColor.black.cgColor
            hoursBackground.layer.shadowOpacity = 0.50
            hoursBackground.layer.shadowOffset = CGSize(width: 1.0, height:1.0)
            
            dateBackground.layer.shadowColor = UIColor.black.cgColor
            dateBackground.layer.shadowOpacity = 0.50
            dateBackground.layer.shadowOffset = CGSize(width: 1.0, height:1.0)
        }

        
        
        //customizing UILabels
        let newColor = UIColor.black.cgColor

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
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MMM-dd")
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
        
        
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.month, .day, .year]
        formatter.maximumUnitCount = 2
    }
    
    
    @objc func finalDonePressed() {
        
        let fakeDate = "March 23, 2018"
        let fakePace = "2 hours/day"
        let fakeTitle = "Where the Wild Things Are"
        
        let newReading =  Reading(context: MangagedSingleton.managedObjectContext)
        newReading.name = fakeTitle
        newReading.pace = fakePace
        newReading.dueDate = fakeDate
        
        do {
            try MangagedSingleton.managedObjectContext.save()
        } catch {
            print("Oh shit nigga, something went wrong.")
        }
        

   }
    
    let userCalendar = Calendar.current
    let calendarComponents : Set<Calendar.Component> = [.month, .day, .year]
    
    func calculatePlan()
    {
        let startDate = currentDateTextField.text
        let fullfinalDate = datePickerText.text
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let date = formatter.date(from: startDate!)
        let endingDate = formatter.date(from: fullfinalDate!)
        print(date!)
        print(endingDate!)
        
        formatter.dateFormat = "MM/dd/yyyy"
        let startTime = date
        let endTime = endingDate
        
        let timeDifference = userCalendar.dateComponents(calendarComponents, from: startTime!, to: endTime!)
        let diffMonth = timeDifference.month!
        let diffDay = timeDifference.day!
        
        
        
   

    }
}


