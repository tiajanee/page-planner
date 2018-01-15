//
//  TimerViewController.swift
//  PagePlaner
//
//  Created by Tia King on 1/14/18.
//  Copyright © 2018 Tia King. All rights reserved.
//

import UIKit



class TimerViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    var time = 0.00
    //timer
    var timer = Timer()
    
    @IBAction func resetButton(_ sender: Any) {
        timer.invalidate()
        time = 0.00
        timerLabel.text = "0.00"
    }
    @IBAction func endTimer(_ sender: UIButton) {
        timer.invalidate()
    }
    @IBAction func startTimer(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TimerViewController.action), userInfo: nil, repeats: true)
    }
    @objc func action() {
        time += 0.01
        timerLabel.text = String(format: "%3.2f", time)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
