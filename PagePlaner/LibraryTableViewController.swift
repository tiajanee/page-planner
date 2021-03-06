//
//  LibraryTableViewController.swift
//  PagePlaner
//
//  Created by Tia King on 2/7/18.
//  Copyright © 2018 Tia King. All rights reserved.
//

import UIKit
import CoreData

public final class ManagedSingleton {
    static let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

}

class LibraryTableViewController: UITableViewController {
    
    var readings = [Reading]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "LIBRARY"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "LibreBarcode39Text-Regular", size: 40)!]
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        loadData()
        
        //if there are no readings in the library, raise Alert
        if tableView.visibleCells.isEmpty {
        
            let imageName = "emptyTableView"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            
            imageView.frame = CGRect(x: 0, y: 50, width: 300, height: 200)
            imageView.translatesAutoresizingMaskIntoConstraints = true
            imageView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
            imageView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
            view.addSubview(imageView)

            
            
        }
        
    }
    
    func loadData() {
        let readingRequest:NSFetchRequest<Reading> = Reading.fetchRequest()
        
        do {
            readings = try ManagedSingleton.managedObjectContext.fetch(readingRequest)
            self.tableView.reloadData()
        } catch {
            print("could not retrieve the data.")
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

    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .normal, title:"Delete") { (_, indexPath) in
            let reading = self.readings[indexPath.row]
            
            // remove the reading from our tableview
            self.readings.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            

            let context = ManagedSingleton.managedObjectContext
            context.delete(reading)
            
            //save changes
            do {
                try context.save()
            } catch _ {
            }
         }
        return [deleteAction]
    }
    
   
    

}
