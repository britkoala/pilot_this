//
//  ViewController.swift
//  Pilot this
//
//  Created by Fernando Rios Garate on 2/3/15.
//  Copyright (c) 2015 BlueKoala. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var productsTableView: UITableView!
    
    var products = [Product]()
    
    // MARK: ViewController Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Add button that toggles between edit and done
        //self.navigationItem.leftBarButtonItem = self.editButtonItem()

    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        
        productsTableView.setEditing(editing, animated: animated) // Set table editing
        
        addButton.enabled = !editing // Disable addButton when editing
        
    }
    
    //Fetching from persistent storage
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"Product")
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [Product]?

        
        if let results = fetchedResults {
            products = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        if (products.count > 0){
            self.navigationItem.leftBarButtonItem = self.editButtonItem()
        }
        
    }
    //END: Fetching
    
    
    // MARK: TableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if products.count == 0 {
            // Show placeholder
            var placeholderLabel = UILabel(frame: productsTableView.bounds)
            
            placeholderLabel.text = "To add a new pilot, press the '+'\nbutton on the top right corner."
            placeholderLabel.textColor = UIColor.blackColor()
            placeholderLabel.numberOfLines = 0
            placeholderLabel.textAlignment = NSTextAlignment.Center
            placeholderLabel.font = UIFont(name: "Palatino-Italic", size: 20)
            placeholderLabel.sizeToFit()
            
            productsTableView.backgroundView = placeholderLabel
            
        } else {
            // Remove placeholder
            productsTableView.backgroundView = nil
        }
        
        return products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath) as ProductTableViewCell
        
        let product = products[indexPath.row]
        cell.product = product
        
        return cell
    }
    
    // TableView Allow Edit(Delete)
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Show multiple options when the user swipes horizontally on a cell
    /*func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var moreAction = UITableViewRowAction(style: .Normal, title: "More") { action, indexPath in
            println("More action on indexPath: \(indexPath)")
        }
        
        var deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { action, indexPath in
            println("Delete action on indexPath: \(indexPath)")
        }
        
        return [deleteAction, moreAction]
        
    }*/

    // Table View Commit Edit(Delete)
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            // Get shared context
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            var context = appDelegate.managedObjectContext!
            
            // Set product for deletion
            context.deleteObject(products[indexPath.row])
            
            // Save context
            var error: NSError?
            if context.save(&error) {
                
                products.removeAtIndex(indexPath.row)
                productsTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                
                if (products.count == 0){
                    self.navigationItem.leftBarButtonItem = nil
                    self.setEditing(false, animated: true)
                }
                
            } else {
                println(error)
            }
        }
    }
    // END: TableViewDelegate
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "ShowProductDetails":
            var detailsViewController = segue.destinationViewController as DetailsViewController
            let indexPath = productsTableView.indexPathForSelectedRow()!
            detailsViewController.product = products[indexPath.row]
        default: break
        }
    }

}

