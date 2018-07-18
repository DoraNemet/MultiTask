//
//  ViewController.swift
//  MultiTask
//
//  Created by Dora Fundak on 18/07/2018.
//  Copyright © 2018 Dora Fundak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOnScreen:Double = 0
    var previousNumber:Double = 0
    var preformingOperation = false
    var operation = 0
    
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
        if operation == 14 {
            lastNumberLabel.text = currentLabel.text
            currentLabel.text = ""
            operation = 0
            preformingOperation = false
        }
        if preformingOperation == true {
            currentLabel.text = String(sender.tag)
            numberOnScreen = Double(currentLabel.text!)!
            preformingOperation = false
        } else {
            currentLabel.text = currentLabel.text! + String(sender.tag)
            numberOnScreen = Double(currentLabel.text!)!
        }
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        if sender.tag == 14 { // =
            lastNumberLabel.text = currentLabel.text
            if operation == 10 {
                currentLabel.text = String(previousNumber / numberOnScreen)
            } else if operation == 11 {
                currentLabel.text = String(previousNumber * numberOnScreen)
            } else if operation == 12 {
                currentLabel.text = String(previousNumber - numberOnScreen)
            } else if operation == 13 {
                currentLabel.text = String(previousNumber + numberOnScreen)
            }
            operation = 14
        } else if sender.tag == 15 { //clear
            lastNumberLabel.text = ""
            currentLabel.text = ""
            numberOnScreen = 0
            preformingOperation = false
            previousNumber = 0
            operation = 0
        } else if currentLabel.text != "" {
            if  currentLabel.text != "/" && currentLabel.text != "+" && currentLabel.text != "x" && currentLabel.text != "-" {
                previousNumber = Double(currentLabel.text!)!
                lastNumberLabel.text = currentLabel.text
            }
            
            if sender.tag == 10 { // /
                currentLabel.text = "/"
            } else if sender.tag == 11 { // x
                currentLabel.text = "x"
            } else if sender.tag == 12 {// -
                currentLabel.text = "-"
            } else if sender.tag == 13 {// +
                currentLabel.text = "+"
            }
            operation = sender.tag
            preformingOperation = true;
        }
    }
    


}

