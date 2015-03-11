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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        productsTableView.setEditing(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Fetching from persistent storage
    
    var products = [Product]()
    
    @IBOutlet weak var productsTableView: UITableView!
    
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
        cell.picture.image = product.picture
        cell.nameLabel.text = product.name
        cell.daysLabel.text = product.daysAsString()
        

        
        return cell
    }
    
    // TableView Edit (Delete)
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
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

