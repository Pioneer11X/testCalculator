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
    
    var userIsInTheMiddleOfTyping = false
    
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
        let digit = sender.currentTitle!
        if ( userIsInTheMiddleOfTyping ){
            display.text = display.text! + digit
        } else{
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        operandStack.append(displayValue)
        print(operandStack)
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

