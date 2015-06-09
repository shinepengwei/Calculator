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
    var operandStack = Array<Double>()
    
    @IBAction func operate(sender: UIButton) {
        let operatoion = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber{
            enter()
        }
        switch operatoion{
        case "×": performOperation{$0 * $1}
        case "÷": performOperation{$1 / $0}
        case "+": performOperation{$0 + $1}
        case "−": performOperation{$1 - $0}
        
        default:
            break

        }
    }
    func performOperation(operation:(Double,Double)->Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
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

