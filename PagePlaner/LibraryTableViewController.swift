//
//  LibraryTableViewController.swift
//  PagePlaner
//
//  Created by Tia King on 2/7/18.
//  Copyright © 2018 Tia King. All rights reserved.
//

import UIKit
import CoreData

public final class MangagedSingleton {
    static let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

}

class LibraryTableViewController: UITableViewController {
    
    var readings = [Reading]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "LIBRARY"
    self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "LibreBarcode39Text-Regular", size: 40)!]
        
    self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        loadData()
    }
    
    func loadData() {
        let readingRequest:NSFetchRequest<Reading> = Reading.fetchRequest()
        
        do {
            readings = try MangagedSingleton.managedObjectContext.fetch(readingRequest)
            self.tableView.reloadData()
        } catch {
            print("oh no nigga")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibCell", for: indexPath) as! ReadingsTableViewCell

        // Configure the cell...
        
        let readingItem = readings[indexPath.row]
        cell.calcDate.text = readingItem.dueDate
        cell.calcName.text = readingItem.name
        cell.calcPace.text = readingItem.pace

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            let readingRequest:NSFetchRequest<Reading> = Reading.fetchRequest()
            
            do {
                readings = try MangagedSingleton.managedObjectContext.fetch(readingRequest)
            } catch {
                print("oh no nigga")
            }
            if let result = try? MangagedSingleton.managedObjectContext.fetch(readingRequest) {
                for object in result {
                    MangagedSingleton.managedObjectContext.delete(object)

                }
            }
            tableView.reloadData()
            print("delete tableview cell")


        }
    }
   
    

}
