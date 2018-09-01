//
//  ViewController.swift
//  MultiTask
//
//  Created by Dora Fundak on 18/07/2018.
//  Copyright © 2018 Dora Fundak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
      
    var va:Double = 0
    var vb:Double = 0
    
    var display:String = ""
    var currentOperator:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var lastNumberLabel: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {
        if currentOperator == "=" {
            currentOperator =  ""
            va = 0.0
            vb = 0.0
            lastNumberLabel.text = ""
        }
        display += String(sender.tag)
        currentLabel.text = display
    }
    
    @IBAction func equals(_ sender: UIButton) {
        if (currentOperator != "") {
            vb = Double(currentLabel.text!)!
            
            if (currentOperator == "+") {
                va = va + vb
            } else if (currentOperator == "-") {
                va = va - vb
            } else if (currentOperator == "x") {
                va = va * vb
            } else {
                va = va / vb
            }
            lastNumberLabel.text = String(va)
            currentOperator = "="
            currentLabel.text = ""
            vb = 0.0
            display = ""
        }
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        
        var b = ""
        
        if(sender.tag == 10){
            b = "/"
        } else if(sender.tag == 11){
            b = "x"
        } else if(sender.tag == 12){
            b = "-"
        } else if(sender.tag == 13){
            b = "+"
        }
        
         if (currentOperator != "" && currentOperator != "=") {
            display = "";
            vb = Double(currentLabel.text!)!
            
            if (currentOperator == "+") {
                va = va + vb
            } else if (currentOperator == "-") {
                va = va - vb
            } else if (currentOperator == "x") {
                va = va * vb
            } else {
                va = va / vb
            }
            lastNumberLabel.text = String(va)
            currentOperator = b
            currentLabel.text = currentOperator
            
         } else if (currentOperator == "" && display == "") {
            return;
         } else {
            display = "";
            currentOperator = b
            if (lastNumberLabel.text != "") {
                va = Double(lastNumberLabel.text!)!
            } else {
                va = Double(currentLabel.text!)!
            }
            currentLabel.text = currentOperator
            lastNumberLabel.text = String(va)
        }
    }
    
    @IBAction func removeOne(_ sender: UIButton) {
        let textC:String = String(currentLabel.text!);
        if (textC != "") {
            display = String(textC.dropLast())
            currentLabel.text = display
        }
    }

    @IBAction func AC(_ sender: UIButton) {
        display = ""
        currentOperator = ""
        va = 0.0
        vb = 0.0
        currentLabel.text = ""
        lastNumberLabel.text = ""
        currentLabel.text = display
    }
}
