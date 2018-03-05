//
//  TimerViewController.swift
//  PagePlaner
//
//  Created by Tia King on 1/14/18.
//  Copyright © 2018 Tia King. All rights reserved.
//

import UIKit
import CoreData
public var timeElapsed = ""

class TimerViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    
    //initial time starts at 0
    var time = 0.00
    //timer
    var timer = Timer()
    @IBAction func resetButton(_ sender: Any) {
        //stops timer and resets it back to 0
        timer.invalidate()
        time = 0.00
        timerLabel.text = "0.00"

    }
    @IBAction func endTimer(_ sender: UIButton) {
        //does not allow user to enter empty time
        if timerLabel.text == "0.00" {
            let noTimeAlert = UIAlertController(title: "Did you time yourself?", message: "If you submit an empty time, you won't get a reading plan. 😤", preferredStyle: .alert)
            
            noTimeAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(noTimeAlert, animated: true)
            return
        }
        
        //stops timer
        timer.invalidate()
        
        timeElapsed = timerLabel.text!
    
       
        

        
        
    }
        
    @IBAction func startTimer(_ sender: Any) {
        //timer with milliseconds
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TimerViewController.action), userInfo: nil, repeats: true)
    }
    @objc func action() {
        //formatting timers
        time += 0.01
        timerLabel.text = String(format: "%3.2f", time)
    }
    override func viewDidLoad() {
        self.navigationItem.title = "TIMER"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "LibreBarcode39Text-Regular", size: 40)!]
       
        
        //directions for how to use the app
        let howToAlert = UIAlertController(title: "How to get the most accurate reading time...", message: "Pick any full page and time yourself reading that singular page from start to finish. Relax and take your time, no one is quizzing you. 😉", preferredStyle: .alert)
        
        howToAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(howToAlert, animated: true)
        
        
        endButton.layer.shadowColor = UIColor.black.cgColor
        endButton.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        endButton.layer.shadowOpacity = 0.50
        startButton.layer.shadowColor = UIColor.black.cgColor
        startButton.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        startButton.layer.shadowOpacity = 0.50
        resetButton.layer.shadowColor = UIColor.black.cgColor
        resetButton.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        resetButton.layer.shadowOpacity = 0.50
   
        
        timerLabel.layer.shadowOpacity = 1
        timerLabel.layer.shadowColor = UIColor.gray.cgColor
        timerLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
