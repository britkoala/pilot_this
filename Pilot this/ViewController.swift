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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Add button that toggles between edit and done
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        
        productsTableView.setEditing(editing, animated: animated) // Set table editing
        
        addButton.enabled = !editing // Disable addButton when editing
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
    //END: Fetching
    
    
    // START: TableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath) as ProductTableViewCell
        
        let product = products[indexPath.row]
        cell.product = product
        
        /* gutivg: Assignments moved to ProductTableViewCell. Elements updated when product is set.
        
//        cell.picture.image = product.picture
//        cell.nameLabel.text = product.name
//        cell.daysLabel.text = product.daysAsString()
        
        */
        
        return cell
    }
    
    // TableView Allow Edit(Delete)
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
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

