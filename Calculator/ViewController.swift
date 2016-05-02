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

    @IBAction func performOperation(sender: UIButton) {
        isUserInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            if mathematicalSymbol == "∏" {
                display.text = String(M_PI)
            }
        }
    }
}

