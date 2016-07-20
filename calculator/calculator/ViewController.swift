//
//  ViewController.swift
//  calculator
//
//  Created by 游宗翰 on 2016/7/10.
//  Copyright © 2016年 han. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    var userIsTypingANumber:Bool = false
    
    @IBAction func appendDigit(_ sender: UIButton)
    {
        let digit = sender.currentTitle!
        
        if userIsTypingANumber
        {
            display.text = display.text! + digit
        }
        else
        {
            display.text =  digit
            userIsTypingANumber = true
        }
        
    }
    
    @IBAction func operate(_ sender: UIButton)
    {
        let operation = sender.currentTitle!
        if userIsTypingANumber
        {
            enter()
        }
        switch operation {
        case "÷":
            performOperation{$1 / $0}
        case "×":
            performOperation{$0 * $1}
        case "−":
            performOperation{$1 - $0}
        case "+":
            performOperation{$0 + $1}
        case "√":
            performOperation{sqrt($0)}
        default:
            break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double)
    {
        if operandStack.count >= 2
        {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    func performOperation(operation2: (Double) -> Double)
    {
        if operandStack.count >= 1
        {
            displayValue = operation2(operandStack.removeLast())
            enter()
        }
    }
    
    
    var operandStack = [Double]()
    var displayValue : Double{
        get{
            return Double(display.text!)!
        }set{
            display.text = "\(newValue)"
            userIsTypingANumber = false
        }
    }
    @IBAction func enter()
    {
        userIsTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
}

