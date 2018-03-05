//
//  ReadingDetailsViewController.swift
//  PagePlaner
//
//  Created by Tia King on 1/14/18.
//  Copyright © 2018 Tia King. All rights reserved.
//

import UIKit
import CoreData

class ReadingDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1 {
            return 1
        }
        
        return 0
    }

    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200.0
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45.0
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
            pickerLabel?.backgroundColor = UIColor.darkGray
        }
        let titleData = hoursGoalPickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "Courier New", size: 25.0)!,NSAttributedStringKey.foregroundColor:UIColor.white])
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
    let hoursGoalPickerData = ["0","1", "2", "3", "4", "5", "6", "7", "8"]

    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        cancelReading()
    }
    
    @IBAction func finalDonePressed(_ sender: Any) {
        calculatePlan()
    }
    var managedObjectContext:NSManagedObjectContext!
    let datePicker = UIDatePicker()
    
        

    override func viewDidLoad() {
        super.viewDidLoad()
        print(timeElapsed)
        createDatePicker()
        hoursGoalPicker.backgroundColor = UIColor.darkGray
        hoursGoalPicker.layer.borderWidth = 0.35
        hoursGoalPicker.layer.borderColor = UIColor.black.cgColor
        
        self.navigationItem.title = "PLAN"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "LibreBarcode39Text-Regular", size: 40)!]

        dateBackground.layer.borderWidth = 0.35
        dateBackground.layer.borderColor = UIColor.gray.cgColor
        
        hoursBackground.layer.borderWidth = 0.35
        hoursBackground.layer.borderColor = UIColor.gray.cgColor
        

        
        
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
            
            
            //customizing the UILabels in the calculation section
            hoursBackground.layer.shadowColor =  UIColor.black.cgColor
            hoursBackground.layer.shadowOpacity = 0.50
            hoursBackground.layer.shadowOffset = CGSize(width: 1.0, height:1.0)
            
            dateBackground.layer.shadowColor = UIColor.black.cgColor
            dateBackground.layer.shadowOpacity = 0.50
            dateBackground.layer.shadowOffset = CGSize(width: 1.0, height:1.0)
        }

        
       

        //adding data from array to UIPickers
        hoursGoalPicker.dataSource = self
        hoursGoalPicker.delegate = self
        
        hoursGoalPicker.layer.borderWidth = 0.5
        hoursGoalPicker.frame = CGRect(x: 0, y: 0, width: 200, height: 50)

        
        
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
      

    }
    
    func createDatePicker() {
        
        datePicker.datePickerMode = .date
        
        //prevents user from choosing goal date earlier than current date
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
    
    @objc func cancelReading() {
        self.performSegue(withIdentifier: "cancel", sender: self)
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
    
    
    let userCalendar = Calendar.current
    let calendarComponents : Set<Calendar.Component> = [.month, .day, .year]
    
    @objc func calculatePlan()
    {
        
        //Checking text fields for empty strings
        if numOfPagesTextField.text == "" {
            let alert = UIAlertController(title: "Did you enter the number of pages you have to read?", message: "Please enter a page number.", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            self.present(alert, animated: true)
            
            return
        }
        let numText = numOfPagesTextField.text
        if titleTextField.text == "" {
            let alert = UIAlertController(title: "Did you enter a title for your reading?", message: "Please enter a title.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
            return
        }
        
        let titleText = titleTextField.text
        
        guard let datePickerText = datePickerText.text
        else {return }
        
       
        //grabbing inputed dates from ViewController
        let startDate = currentDateTextField.text
        let selectedHourGoal = Float(hoursGoalPickerData[hoursGoalPicker.selectedRow(inComponent: 0)])
        
        //if user fills out either column for readingPlan, raise UIAlertController
        if selectedHourGoal == 0 && datePickerText == "" {
            let alert = UIAlertController(title: "Did you choose a goal date or a goal hour per day?", message: "Please choose one or the other and not both.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
            return
        }
        
        
        //formatting date
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let date = formatter.date(from: startDate!)
        let startTime = date
        
        
        //changing number strings to floats to be operated on
        let numInt = Float(numText!)
        let numPace = Float(timeElapsed)!
        
        //checking for non-numerical values in numOfPagesTextField
        if numInt == nil {
            let alert = UIAlertController(title: "Did you input non-numerical values for page numbers?", message: "Please use numbers 0-9 only.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
            return
        }
        
        //multiplying reading/page time by number of pages in book to get time(seconds) approximately user will spend reading in total
        let totalTime = (numInt!*numPace)
        let hourTime = Int(totalTime/3600)
        
      
        
        if selectedHourGoal != 0 {
            let newReading =  Reading(context: ManagedSingleton.managedObjectContext)
            //formatting date that appears in table view cell
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MMM-dd")
            
            //diving seconds by 3600 to get total reading time in hours
            let daysSpentReading = hourTime/Int(selectedHourGoal!)
            let finishDate = Calendar.current.date(byAdding: .day, value: daysSpentReading, to: startTime!)
            
            //setting the reading details in entities in Core Data
            let formatFinishDate = dateFormatter.string(from: finishDate!)
            newReading.name = titleText
            newReading.pace = String(describing: Double(selectedHourGoal!)) + " hrs/day"
            newReading.dueDate = formatFinishDate
            
            //saves reading details to Core Data
            do {
                try ManagedSingleton.managedObjectContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        } else {
            let newReading =  Reading(context: ManagedSingleton.managedObjectContext)
            //formatting the Date strings to Date objects
            let fullfinalDate = datePickerText
            let endingDate = formatter.date(from: fullfinalDate)
           
            let endTime = endingDate
            
            //using User Calendar to find time elapsed between current date and goal date
            let timeDifference = userCalendar.dateComponents(calendarComponents, from: startTime!, to: endTime!)
            let diffMonth = timeDifference.month!
            let diffDay = timeDifference.day!
            let monthtoDay = (diffMonth*30)
            let totalDays = (monthtoDay + diffDay)
            
            //calculating reading time required per day
            let timePerDay = Double((Float(hourTime)/Float(totalDays)))
            let roundedHourPerDay = Double(round(1000*timePerDay)/1000)
            let roundedMinPerDay = Double(round(1000*timePerDay*60)/1000)
            
            //formatting date in table view cell
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MMM-dd")
            let formatEndTime = dateFormatter.string(from: endTime!)
            if timePerDay > 1.0 {
                
                //converts hours to minutes if reading pace under an hour
                newReading.name =  titleText
                newReading.pace = String(roundedHourPerDay) + " hrs/day or " + String(roundedMinPerDay) + " min/day"
                newReading.dueDate = formatEndTime
                
                
                //saves new reading to be displayed in LibraryTableView
                do {
                    try ManagedSingleton.managedObjectContext.save()
                } catch {
                    fatalError("Failure to save context: \(error)")
                }
                
            } else {
                newReading.name =  titleText
                newReading.pace = String(roundedMinPerDay) + " min/day"
                newReading.dueDate = formatEndTime
                
            do {
                try ManagedSingleton.managedObjectContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            
            }
        }


    }
}


