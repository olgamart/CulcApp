//
//  ViewController.swift
//  CulcApp
//
//  Created by Olga Martyanova on 16/11/2017.
//  Copyright © 2017 olgamart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var arrayButtons: [UIButton]!
    @IBOutlet weak var resLabel: UILabel!    
    @IBOutlet weak var zeroButton: UIButton!
    var firstNul = false
    var firsOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    var dotIsPlaced = false
    var str: String = ""
    var strArray = [String]()
    var mathButtonPressed = false
    var equalButtonPressed = false
    
    
    var currentInput: Double {
        
        get {
            
            str = resLabel.text!
            strArray = str.components(separatedBy: ",")
            if strArray.count>1 {str = strArray[0] + "." + strArray[1]}
            return Double(str)!
            
        }
        set{
            str = "\(newValue)"
            strArray = str.components(separatedBy: [",","."])
            if strArray.count>1 {
            if strArray[1] == "0" {
                resLabel.text = "\(strArray[0])"
            } else{
                resLabel.text = strArray[0] + "," + strArray[1]
            }
            } else {resLabel.text = "\(strArray[0])"}
            firstNul = false
        }
    }
    
    @IBAction func didgitButton(_ sender: UIButton) {
        let number = sender.currentTitle!
        if firstNul{
            if resLabel.text!.count < 20 {
                if resLabel.text != "0"{
                   resLabel.text = resLabel.text! + number}
                else {resLabel.text = number}
            }
        } else {
            resLabel.text = number
            firstNul = true
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for button in arrayButtons {
            button.layer.cornerRadius = button.frame.height / 2
        }
        zeroButton.layer.cornerRadius = zeroButton.frame.height / 2
        zeroButton.contentEdgeInsets = UIEdgeInsetsMake(0,0,0,zeroButton.frame.height)
          
    }
        
    
    @IBAction func mathButton(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firsOperand = currentInput
        firstNul = false
        dotIsPlaced = false
        mathButtonPressed = true
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
        
        if firstNul {
            secondOperand = currentInput
        }
        dotIsPlaced = false
        
        switch operationSign {
            case "+": currentInput = firsOperand + secondOperand
            case "-": currentInput = firsOperand - secondOperand
            case "×": currentInput = firsOperand * secondOperand
            case "÷": if secondOperand == 0.0 {resLabel.text = "Not a number"} else{ currentInput = firsOperand / secondOperand}
        default: break
        }
        if !equalButtonPressed{
        firsOperand = 0
        firstNul = false
        equalButtonPressed = true
    }
        
    }
    @IBAction func clearButton(_ sender: UIButton) {
        firsOperand = 0
        secondOperand = 0
        currentInput = 0
        resLabel.text = "0"
        firstNul = false
        dotIsPlaced = false
        operationSign = ""
        mathButtonPressed = false
        equalButtonPressed = false
    }
    
    @IBAction func plusMinusButton(_ sender: UIButton) {
        if resLabel.text != "0" {currentInput = -currentInput
        firstNul = true
        }
    }
    
    @IBAction func percentButton(_ sender: UIButton) {
        
        if firsOperand == 0{
            if mathButtonPressed {currentInput = 0}
            else {currentInput = currentInput/100}
        }
        
        else{
            secondOperand = firsOperand/100.0 * currentInput
            currentInput = secondOperand
        
            }
    firstNul = false
        mathButtonPressed = false
        
    }
    
    @IBAction func dotButton(_ sender: UIButton) {
        if firstNul && !dotIsPlaced {
            resLabel.text = resLabel.text! + ","
            dotIsPlaced = true
        } else if !firstNul && !dotIsPlaced{
            resLabel.text = "0,"
            dotIsPlaced = true
            firstNul = true
        }
    }
}

