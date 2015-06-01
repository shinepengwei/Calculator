//
//  ViewController.swift
//  Calculator
//
//  Created by yangpengwei on 15/6/1.
//  Copyright (c) 2015年 yangpengwei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingNumber:Bool = false

    @IBAction func appendDigit(sender: UIButton)   {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber {
            display.text = display.text! + digit
            
        }else{
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }
        
        println("digit = \(digit)")
    }
}

