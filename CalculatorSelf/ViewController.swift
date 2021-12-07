//
//  ViewController.swift
//  CalculatorSelf
//
//  Created by LrUCiA on 2021/11/13.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var calculatorMain = CalculatorMain()
    
    var displayValue: Double {
        get {
            return Double(showDigit.text!)!
        }
        set{
            showDigit.text = String(newValue)
        }
    }
    var userIsTyping = false
    
    @IBOutlet weak var showDigit: UITextField!
    
    @IBAction func digitButton(_ sender: UIButton) {
        let digit = (sender.currentTitle)!
        if userIsTyping {
            let textCurrentlyInDisplay = showDigit.text!
            if textCurrentlyInDisplay.contains(".") && digit.contains("."){
                showDigit.text = textCurrentlyInDisplay
            }
            else {showDigit.text = textCurrentlyInDisplay + digit}
            
        } else if digit.contains("."){
            showDigit.text = "0"+digit
        }
        else {
            showDigit.text = digit
        }
        userIsTyping = true
    }
    

    @IBAction func operationButton(_ sender: UIButton) {
        if userIsTyping {
            calculatorMain.setOperand(operand: displayValue)
        }
        userIsTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            calculatorMain.startOperation(symbol: mathematicalSymbol)
        }
        displayValue = calculatorMain.result
    }
}

