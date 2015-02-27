//
//  NewViewController.swift
//  Pilot this
//
//  Created by Fernando Rios Garate on 2/11/15.
//  Copyright (c) 2015 BlueKoala. All rights reserved.
//

import UIKit

class NewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var selectImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        
        // Change placeholder color
        productName.attributedPlaceholder = NSAttributedString(string: "Product Name", attributes: [NSForegroundColorAttributeName: UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1)])
        productPrice.attributedPlaceholder = NSAttributedString(string: "Price (Aprox.)", attributes: [NSForegroundColorAttributeName: UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1)])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickImage(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        pickedImage.image = image
        selectImageButton.setTitle("", forState: .Normal)
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
