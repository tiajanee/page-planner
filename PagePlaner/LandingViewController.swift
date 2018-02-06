//
//  ViewController.swift
//  PagePlaner
//
//  Created by Tia King on 1/14/18.
//  Copyright © 2018 Tia King. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var toTimerButton: UIButton!
    @IBOutlet weak var toLibraryButton: UIButton!
    @IBOutlet weak var landingText: UITextView!
    @IBOutlet weak var libBackground: UIImageView!
    @IBOutlet weak var readBackground: UIImageView!
    @IBOutlet weak var welcomeText: UITextView!
    override func viewDidLoad() {
        //specifying custom font
        landingText.font = UIFont(name:"LibreBarcode39Text-Regular", size: 70.0)
        landingText.layer.opacity = 0.30
        
        //Adding shadows to text, cleaner look
        welcomeText.layer.shadowColor = UIColor.black.cgColor
        welcomeText.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        welcomeText.layer.shadowOpacity = 1.0
        welcomeText.layer.shadowRadius = 2.0
        welcomeText.layer.backgroundColor = UIColor.clear.cgColor
        
//        toLibraryButton.layer.shadowColor = UIColor.gray.cgColor
//        toLibraryButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        toLibraryButton.layer.shadowOpacity = 0.60
//
//        toTimerButton.layer.shadowColor = UIColor.gray.cgColor
//        toTimerButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        toTimerButton.layer.shadowOpacity = 0.60
//
        libBackground.layer.borderWidth = 0.80
        libBackground.layer.borderColor = UIColor.black.cgColor
        libBackground.layer.opacity = 0.70
        
        readBackground.layer.borderWidth = 0.80
        readBackground.layer.borderColor = UIColor.black.cgColor
        readBackground.layer.opacity = 0.70
        
        libBackground.layer.shadowColor = UIColor.black.cgColor
        libBackground.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        libBackground.layer.shadowOpacity = 0.60
        
        readBackground.layer.shadowColor = UIColor.black.cgColor
        readBackground.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        readBackground.layer.shadowOpacity = 0.60
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

