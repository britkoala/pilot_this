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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Fetching from persistent storage
    
    var products = [Product]()
    
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
    
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath) as ProductTableViewCell
        
        let product = products[indexPath.row]
        cell.nameLabel.text = product.name
        cell.daysLabel.text = "\(product.days)"
        cell.picture.image = product.picture
        
        return cell
    }

}

