//
//  DetailsViewController.swift
//  Pilot this
//
//  Created by Gustavo Villar on 2/3/15.
//  Copyright (c) 2015 BlueKoala. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, JBLineChartViewDataSource, JBLineChartViewDelegate {

    @IBOutlet weak var levelSlider: UISlider!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var chartView: UIView!
    
    var lineChartView: JBLineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lineChartView = JBLineChartView()
        lineChartView.dataSource = self
        lineChartView.delegate = self
        self.chartView.addSubview(lineChartView)
//        lineChartView.frame = CGRectMake(0, 0, chartView.frame.width+50, chartView.frame.height)
//        lineChartView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // JBLineChartViewDataSource
    func numberOfLinesInLineChartView(lineChartView: JBLineChartView!) -> UInt {
        return 1
    }
    
    func lineChartView(lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        return 7
    }
    
    // END:JBLineChartViewDataSource
    
    
    
    // JBLineChartViewDelegate
    
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"Person")
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            people = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    //END: Fetching
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //var cell = tableView.dequeueReusableCellWithIdentifier("CravingCell", forIndexPath: indexPath) as UITableViewCell
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CravingCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = "test"
        
        return cell
    }
    
    @IBAction func levelSliderChanged(sender: AnyObject) {
        levelLabel.text = "\(Int(levelSlider.value))"
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {

//        lineChartView.frame = CGRectMake(0, 0, size.width - 32, lineChartView.frame.height)
//        lineChartView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lineChartView.frame = CGRectMake(0, 0, chartView.frame.width, chartView.frame.height)
        lineChartView.reloadData()
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
