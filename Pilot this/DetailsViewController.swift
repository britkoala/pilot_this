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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var levelSlider: UISlider!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var chartView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var annotationsTableView: AutoresizableTableView!
    
    var lineChartView: JBLineChartView!
    
    var product: Product! {
        didSet {
            // Sort annotations (most recent first) and store them as an Array
            annotations = product.annotations.allObjects as [Annotation]
            annotations.sort { $0.created_at.compare($1.created_at) == NSComparisonResult.OrderedDescending }
        }
    }
    
    var annotations: [Annotation]!
    
    // MARK: View Controller Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup Chart
        lineChartView = JBLineChartView()
        lineChartView.dataSource = self
        lineChartView.delegate = self
        lineChartView.backgroundColor = UIColor(white: 0, alpha: 0.25)
        chartView.addSubview(lineChartView)
        
        chartView.image = product.picture
        
        // Glow effect
        addButton.layer.shadowColor = addButton.titleLabel?.textColor.CGColor
        addButton.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        addButton.layer.shadowRadius = 0
        addButton.layer.shadowOpacity = 0.5
        addButton.layer.masksToBounds = false
        
        
        //Keyboard Notifications
        registerForKeyboardNotifications()
        
        // Dismiss Keyboard on Touch
        let keyboardDismisalGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(keyboardDismisalGesture)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Resize chart view
        lineChartView.frame = CGRectMake(0, 0, chartView.frame.width, chartView.frame.height)
        lineChartView.reloadData()
    }
    
    // MARK: Dismiss keyboard
    func dismissKeyboard() {
        view.endEditing(false)
    }
    
    // MARK: Keyboard Notifications
    func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        var keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        
        let contentInsets = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    
    // MARK: JBLineChartViewDataSource
    func numberOfLinesInLineChartView(lineChartView: JBLineChartView!) -> UInt {
        return 1
    }
    
    func lineChartView(lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        return 7
    }
    
    // MARK: JBLineChartViewDelegate
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
    
    // MARK: TableViewDelegate and DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return annotations.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        
        var cell = tableView.dequeueReusableCellWithIdentifier("AnnotationCell", forIndexPath: indexPath) as AnnotationTableViewCell

        cell.annotation = annotations[indexPath.row]
        cell.viewController = self      // ViewController necesary to show alert
        
        return cell
    }

    
    // MARK: Target Actions
    @IBAction func levelSliderChanged(slider: UISlider) {
        let intValue = Int(levelSlider.value + 0.5)
        
        slider.value = Float(intValue)
        levelLabel.text = "\(intValue)"
        addButton.setTitle(Annotation.levelName(intValue), forState: .Normal)
        
    }
    
    // Animate when the user stops editing the levelSlider
    @IBAction func levelEditingDidEnd(sender: UISlider) {
        
        // TO YAYO: Choose which animation you like: glow or jump
        glowAnimation()
        jumpAnimation()
        
    }
    
    // Glow animation for addButton
    func glowAnimation() {
        var glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
        glowAnimation.fromValue = 8
        glowAnimation.toValue = 0
        glowAnimation.duration = 0.7
        addButton.layer.addAnimation(glowAnimation, forKey: "glow")
    }
    
    // Jump animation for addButton
    func jumpAnimation() {
        var jumpAnimation = CAKeyframeAnimation(keyPath: "position.y")
        let jumpOffset = 2
        jumpAnimation.values = [0, -jumpOffset, 0, jumpOffset, 0, -jumpOffset, 0]
//        jumpAnimation.keyTimes = [0, (1/6), (3/6), (5/6), 1] // This doesn't seem to work
        jumpAnimation.duration = 0.4
        jumpAnimation.additive = true
        addButton.layer.addAnimation(jumpAnimation, forKey: "jump")
        
    }
    
    // Inserting Annotation
    @IBAction func addAnnotation(sender: AnyObject) {
        
        
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context = appDelegate.managedObjectContext!
        
        var annotation = NSEntityDescription.insertNewObjectForEntityForName("Annotation", inManagedObjectContext: context) as Annotation
        
        annotation.level = levelSlider.value
        annotation.product = product
        
        
        var error: NSError?
        if !context.save(&error) {
            displayAlert("Could not add annotation", message: "\(error?.userInfo)")
        } else {
            
            println("Annotation with level \(annotation.level) added")
            
            // Insert annotations on array
            annotations.insert(annotation, atIndex: 0)
            
            
            // Insert annotation cell on the table
            let newIndexPath = NSIndexPath(forRow: 0, inSection: 0)
            annotationsTableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
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

