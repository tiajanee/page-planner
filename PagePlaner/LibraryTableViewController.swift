//
//  LibraryTableViewController.swift
//  PagePlaner
//
//  Created by Tia King on 2/7/18.
//  Copyright © 2018 Tia King. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController {
    var readings = ["Where The Wild Things Are", "15 Days",
                    "Grandma Got Runover By A Reindeer"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "LIBRARY"
    self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "LibreBarcode39Text-Regular", size: 40)!]
        
    self.navigationController?.navigationBar.barTintColor = UIColor.white

       

       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibCell", for: indexPath) as! ReadingsTableViewCell

        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

   
    

}
