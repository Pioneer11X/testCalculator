//
//  ViewController.swift
//  testCalculator
//
//  Created by Sravan on 22/12/15.
//  Copyright © 2015 pioneer11x. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var display: UILabel!
    @IBOutlet var history: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    var historyCleared = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(sender: UIButton) {
        
        // We need to get the value from the current label
        // And then we need to update it with appending the pressed digit at the ending.
        var digit = sender.currentTitle!
        
        // We need to first check if the sender is "." and add the logic
        if ( digit == "." ){
            if (( display.text!.rangeOfString(".")) != nil){
                return
            }
        }
        if ( digit == "pi" ){
            digit = "\(22.0/7.0)"
        }
        if ( userIsInTheMiddleOfTyping ){
            display.text = display.text! + digit
        } else{
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
        updateHistory(digit)

    }
    
    func updateHistory ( digit: String ){
        
        if ( historyCleared ){
            history.text = digit
            historyCleared = false
        }
        else{
            history.text = history.text! + digit
        }
    }

    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTyping{
            enter()
        }
        updateHistory(operation)
        switch operation {
        case "*": performOperation { $0 * $1 }
        case "/": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "-": performOperation { $1 - $0 }
        case "sqrt": performOperation { sqrt($0) }
            // Note: We perform the Sine and Cosine operations considering that the arguments passed are in radians.
        case "Sin": performOperation { sin($0) }
        case "Cos": performOperation { cos($0) }

        default: break
        }
    }
    
    func performOperation( operation: (Double,Double)->Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast() , operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation( operation: Double -> Double ){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    @IBAction func clearPressed(sender: UIButton) {
        // It means that the user pressed clear. We need to clear the stack and return this to the initial state.
        operandStack.removeAll()
        display.text = "0"
        history.text = "History"
        historyCleared = true
        userIsInTheMiddleOfTyping = false
    }
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        operandStack.append(displayValue)
        print(operandStack)
        updateHistory("⏎")
    }
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTyping = false
        }
    }

}

