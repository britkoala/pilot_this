//
//  AnnotationTableViewCell.swift
//  Pilot this
//
//  Created by Gustavo Villar on 3/13/15.
//  Copyright (c) 2015 BlueKoala. All rights reserved.
//

import UIKit

class AnnotationTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var levelDescription: UILabel!
    
    var viewController: UIViewController?
    
    var annotation: Annotation! {
        didSet {
            levelDescription.text = annotation.levelName()
            levelLabel.text = "\(annotation.level.intValue)"
            
            var formatter = NSDateFormatter()
            formatter.dateFormat = " dd/MM - hh:mm a"
            
            dateTimeLabel.text = formatter.stringFromDate(annotation.created_at)
            comment.text = annotation.comment
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        comment.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func commentEditingEnd(sender: UITextField) {
        
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context = appDelegate.managedObjectContext!
        
        annotation.comment = comment.text
        
        var error: NSError?
        if !context.save(&error) {
            viewController?.displayAlert("Could not update annotation", message: "\(error?.userInfo)")
        } else {
            println("Annotation comment updated: \(annotation.comment)")
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
