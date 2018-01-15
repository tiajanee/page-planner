//
//  ReadingDetailsViewController.swift
//  PagePlaner
//
//  Created by Tia King on 1/14/18.
//  Copyright © 2018 Tia King. All rights reserved.
//

import UIKit


var inputtedPageNum = Int()
class ReadingDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hoursGoalPickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return hoursGoalPickerData[row]
    }
   
    @IBOutlet weak var backgroundImg: UIImageView!
 
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var hoursGoalPicker: UIPickerView!
    let hoursGoalPickerData = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    @IBOutlet weak var goalDatePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    func addDoneButtonOnNumpad(textField: UITextField) {
        
        let keypadToolbar: UIToolbar = UIToolbar()
        
        // add a done button to the numberpad
        keypadToolbar.items=[
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        ]
        keypadToolbar.sizeToFit()
        // add a toolbar with a done button above the number pad
        numOfPagesTextField.inputAccessoryView = keypadToolbar
    }
    
    @IBOutlet weak var numOfPagesTextField: UITextField!
    
    @IBOutlet weak var currentDateTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        addDoneButtonOnNumpad(textField: numOfPagesTextField)
        numOfPagesTextField.keyboardType = UIKeyboardType.numberPad
        var currentDate = String(describing: Date())
        
        
        
        hoursGoalPicker.dataSource = self
        hoursGoalPicker.delegate = self
        
        goalDatePicker.datePickerMode = .date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMd")
        currentDate = dateFormatter.string(from: Date())
        currentDateTextField.text = currentDate
        //dateFormatter.dateFormat = "MM dd"
        let selectedDate = dateFormatter.string(from: goalDatePicker.date)
        print(selectedDate)
        
        
        // Do any additional setup after loading the view, typically from a nib.

        
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


