//
//  DisplayAlert.swift
//  Pilot this
//
//  Created by Gustavo Villar on 3/18/15.
//  Copyright (c) 2015 BlueKoala. All rights reserved.
//

import UIKit

extension UIViewController {
    func displayAlert(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default) {
            action in
            alert.dismissViewControllerAnimated(true, completion: nil)
            })
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
