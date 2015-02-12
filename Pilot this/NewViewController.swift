//
//  NewViewController.swift
//  Pilot this
//
//  Created by Fernando Rios Garate on 2/11/15.
//  Copyright (c) 2015 BlueKoala. All rights reserved.
//

import UIKit

class NewViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickedDuration: UITextField!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var durationPicker: UIPickerView!
    let pickerData = ["1 week","2 weeks","3 weeks","1 month","2 months"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        durationPicker.dataSource = self
        durationPicker.delegate = self


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Delegates and data sources
        //MARK: Data Sources
        func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerData.count
        }
    
        //MARK: Delegates
        func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
            return pickerData[row]
        }
        
        func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            pickedDuration.text = pickerData[row]
        }

}
