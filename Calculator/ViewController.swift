//
//  ViewController.swift
//  Calculator
//  Stanford CS193P Spring 2016 Class.
//  Stanley Petley, 2/5/16.


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var isUserInTheMiddleOfTyping = false
    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if isUserInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
        else {
            display.text = digit
        }
        isUserInTheMiddleOfTyping = true
    }
    
    var displayValue: Double { //computed property, not stored.
        get {
            return Double(display.text!)! //need to unwrap optional, might not be convertable, right?
        }
        set{
            display.text = String(newValue) //newValue keyword.
        }
    }

    @IBAction func performOperation(sender: UIButton) {
        isUserInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            if mathematicalSymbol == "∏" {
                displayValue = M_PI
            } else if mathematicalSymbol == "√" {
                displayValue = sqrt(displayValue)
            }
        }
    }
}

