//
//  NewViewController.swift
//  Pilot this
//
//  Created by Fernando Rios Garate on 2/11/15.
//  Copyright (c) 2015 BlueKoala. All rights reserved.
//

import UIKit
import CoreData

class NewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var descriptionView: UIView! // Container of both Text Fields
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    // MARK: View Controller Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerForKeyboardNotifications()
        
        // Change placeholder color
        let placeHolderColor = UIColor(white: 185/255, alpha: 1)
        productName.attributedPlaceholder = NSAttributedString(string: "Product Name", attributes: [NSForegroundColorAttributeName: placeHolderColor])
        productPrice.attributedPlaceholder = NSAttributedString(string: "Price (Aprox.)", attributes: [NSForegroundColorAttributeName: placeHolderColor])
        
        // Dismiss Keyboard on Touch
        let keyboardDismisalGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(keyboardDismisalGesture)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Keyboard Notifications
    func registerForKeyboardNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardDidShowNotification, object: nil)
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardDidChangeFrame(notification: NSNotification){
        println("-------------------")
        
        let info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        println("Keyboard size: \(keyboardSize)")
        
        let viewHeight = view.frame.height
        println("View height: \(viewHeight)")
        
        let visibleHeight = viewHeight - keyboardSize.height
        println("Visible height: \(visibleHeight)")
        
        let contentHeight = pickedImage.frame.origin.y + pickedImage.frame.height
        println("Content height: \(contentHeight)")
        
        // Move the content up if its not visible
        if visibleHeight < contentHeight {
            let delta = contentHeight - visibleHeight
            println("Delta: \(delta)")
            
            bottomConstraint.constant = -delta // Move descriptionView up
            
            // Animate constraint change
            UIView.animateWithDuration(0.5) {
                self.view.layoutIfNeeded()
            }
        } else if bottomConstraint.constant != 0 {
            bottomConstraint.constant = 0 // Return descriptionView to its original place
            
            // Animate constraint change
            UIView.animateWithDuration(0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as NSValue).CGRectValue().size
        
        let visibleHeight = view.frame.height - keyboardSize.height
        
        let contentHeight = descriptionView.frame.origin.y + descriptionView.frame.height
        
        // Move the content up if its not visible
        if visibleHeight < contentHeight {
            let delta = contentHeight - visibleHeight
            println("Delta: \(delta)")
            
            bottomConstraint.constant = delta // Move descriptionView up
            
            // Animate constraint change
            UIView.animateWithDuration(1) {
                self.view.layoutIfNeeded()
            }
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        if bottomConstraint.constant != 0 {
            bottomConstraint.constant = 0 // Return descriptionView to its original place
            
            // Animate constraint change
            UIView.animateWithDuration(0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: Pick Image
    @IBAction func pickImage(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    // MARK: Image Picker Controller Delegate
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        pickedImage.image = image
        selectImageButton.setTitle("", forState: .Normal) // Hide button's text
    }
    
    // MARK: Text Field Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard() {
        view.endEditing(false)
    }
    
    
    // MARK: Start Pilot
    
    @IBAction func startPilot(sender: AnyObject) {
        // Validation: name required, image and price optional
        
        var valid = true
        var errorMessages = [String]()
        
        if productName.text.isEmpty {
            valid = false
            errorMessages += ["Please enter a name"]
        }
        
        if valid {
            var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            var context = appDelegate.managedObjectContext!
            
            var product = NSEntityDescription.insertNewObjectForEntityForName("Product", inManagedObjectContext: context) as Product
            
            product.name = productName.text
            product.price = (productPrice.text as NSString).doubleValue
            product.picture = pickedImage.image
            
            var error: NSError?
            if !context.save(&error) {
                displayAlert("Could not start pilot", message: "\(error?.userInfo)")
            } else {
                self.navigationController!.popViewControllerAnimated(true)
            }
            
        } else {
            var message = ". ".join(errorMessages)
            displayAlert("This pilot is not ready", message: message)
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
