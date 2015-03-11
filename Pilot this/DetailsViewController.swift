//
//  DetailsViewController.swift
//  Pilot this
//
//  Created by Gustavo Villar on 2/3/15.
//  Copyright (c) 2015 BlueKoala. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, JBLineChartViewDataSource, JBLineChartViewDelegate {

    @IBOutlet weak var levelSlider: UISlider!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var chartView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    var product: Product!
    
    var lineChartView: JBLineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lineChartView = JBLineChartView()
        lineChartView.dataSource = self
        lineChartView.delegate = self
        lineChartView.backgroundColor = UIColor(white: 0, alpha: 0.25)
        chartView.addSubview(lineChartView)
        
        chartView.image = product.picture
//        chartView.contentMode = UIViewContentMode.ScaleAspectFill
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Resize chart view
        lineChartView.frame = CGRectMake(0, 0, chartView.frame.width, chartView.frame.height)
        lineChartView.reloadData()
    }
    
    // START: JBLineChartViewDataSource
    func numberOfLinesInLineChartView(lineChartView: JBLineChartView!) -> UInt {
        return 1
    }
    
    func lineChartView(lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        return 7
    }
    // END:JBLineChartViewDataSource
    
    // START: JBLineChartViewDelegate
    func lineChartView(lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        
        var value: CGFloat
        
        switch(horizontalIndex){
            
        case 0: value = 50
        case 1: value = 100
        case 2: value = 75
        case 5: value = 75
        default: value = 100
            
        }
        
        return value
        
    }
    
    func lineChartView(lineChartView: JBLineChartView!, widthForLineAtLineIndex lineIndex: UInt) -> CGFloat {
        return 4
    }
    
    func lineChartView(lineChartView: JBLineChartView!, smoothLineAtLineIndex lineIndex: UInt) -> Bool {
        return true
    }
    
    func lineChartView(lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.whiteColor()
    }
    // END: JBLineChartViewDelegate
    
    
    //Fetching from persistent storage
    var annotations = [NSManagedObject]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"Annotation")
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            annotations = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    //END: Fetching
    
    
    // START: TableViewDelegate and DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return annotations.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //var cell = tableView.dequeueReusableCellWithIdentifier("CravingCell", forIndexPath: indexPath) as UITableViewCell
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CravingCell", forIndexPath: indexPath) as UITableViewCell
        
        //cell.textLabel?.text = "test"
        
        let annotation = annotations[indexPath.row]
        cell.textLabel!.text = annotation.valueForKey("comment") as String?
        
        return cell
    }
    // END: TableViewDelegate and DataSource
    
    @IBAction func levelSliderChanged(slider: UISlider) {
        let intValue = Int(levelSlider.value + 0.5)
        
        slider.value = Float(intValue)
        levelLabel.text = "\(intValue)"
        addButton.setTitle(Annotation.levelName(intValue), forState: .Normal)
    }
    


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
