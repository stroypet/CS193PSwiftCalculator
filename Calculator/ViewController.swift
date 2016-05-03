//
//  ViewController.swift
//  Calculator
//  Stanford CS193P Spring 2016 Class.
//  Stanley Petley, 2/5/16.


import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel! //check this later.
    private var userIsInTheMiddleOfTyping = false
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
        else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double { //computed property, not stored.
        get {
            return Double(display.text!)! //need to unwrap optional, might not be convertable, right?
        }
        set{
            display.text = String(newValue) //newValue keyword.
        }
    }
    
    private var brain = CalculatorBrain() //Controller talks through this to get to the model, need CalculatorBrain initializer, also infers it's type by equal sign.
    
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
                brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
}

