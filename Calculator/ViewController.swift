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
    
    var brain = CalculatorBrain()

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
    
    @IBAction func operate(sender: UIButton) {
        let operatoion = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber{
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            }
            else{
                displayValue = 0
            }
        }
    }
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
    }
    var displayValue :Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
        }
    }
}

