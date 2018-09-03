//
//  ViewControllerBlue.swift
//  MultiTask
//
//  Created by Dora Fundak on 21/07/2018.
//  Copyright © 2018 Dora Fundak. All rights reserved.
//

import UIKit

class ViewControllerBlue: UIViewController {
    @IBOutlet weak var fuelPrice: UITextField!
    @IBOutlet weak var fuelConsumption: UITextField!
    @IBOutlet weak var distance: UITextField!
    @IBOutlet weak var tripPrice: UILabel!
    @IBOutlet weak var fuelUsed: UILabel!
    
    var fuelPriceNumber:Double = 0
    var fuelConsumptionNumber:Double = 0
    var distanceNumber:Double = 0
    var tripPriceNumber:Double = 0
    var fuelUsedNumber:Double = 0
   
    @IBAction func endFuelPrice(_ sender: UITextField) {
        fuelPriceNumber = Double(changeComma(textWithComma: fuelPrice.text!))!
        calculateOthers()
    }
    
    @IBAction func endFuelConsumption(_ sender: UITextField) {
        fuelConsumptionNumber = Double(changeComma(textWithComma: fuelConsumption.text!))!
        calculateOthers()
    }

    @IBAction func endDistance(_ sender: UITextField) {
        distanceNumber = Double(changeComma(textWithComma: distance.text!))!
        calculateOthers()
    }
    
    func changeComma (textWithComma: String) -> String {
        if(textWithComma == ""){
            return "0"
        } else {
            return textWithComma.replacingOccurrences(of: ",", with: ".")
        }
    }
    
    func calculateOthers() {
        if(fuelPriceNumber != 0 && fuelConsumptionNumber != 0 && distanceNumber != 0) {
            tripPriceNumber = ((distanceNumber * (fuelConsumptionNumber / 100) * fuelPriceNumber) * 100).rounded()/100
            tripPrice.text = String(tripPriceNumber).replacingOccurrences(of: ".", with: ",")
        }
        
        if(fuelConsumptionNumber != 0 && distanceNumber != 0) {
            fuelUsedNumber = (distanceNumber * (fuelConsumptionNumber / 100) * 100).rounded()/100
            fuelUsed.text = String(fuelUsedNumber).replacingOccurrences(of: ".", with: ",")
        }
        
        if( fuelPriceNumber == 0) {
            tripPrice.text = ""
        }
        if( distanceNumber == 0 || fuelConsumptionNumber == 0) {
            tripPrice.text = ""
            fuelUsed.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         self.addDoneButtonOnKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewControllerBlue.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.fuelPrice.inputAccessoryView = doneToolbar
        self.fuelConsumption.inputAccessoryView = doneToolbar
        self.distance.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.fuelPrice.resignFirstResponder()
        self.fuelConsumption.resignFirstResponder()
        self.distance.resignFirstResponder()
        self.tripPrice.resignFirstResponder()
        self.fuelUsed.resignFirstResponder()
    }
}
