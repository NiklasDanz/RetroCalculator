//
//  ViewController.swift
//  Udemy Retro Calculator
//
//  Created by Niklas Danz on 16.09.16.
//  Copyright © 2016 Niklas Danz. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    
    var currentOperation = Operation.Empty
    
    var result = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func clearPressed(_ sender: AnyObject) {
        playBtnSound()
        
        runningNumber = ""
        leftValString = ""
        rightValString = ""
        currentOperation = Operation.Empty
        result = ""
        outputLbl.text = "0"
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        playBtnSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(_ sender: UIButton) {
        processOperation(.Divide)
    }

    @IBAction func onMultiplyPressed(_ sender: UIButton) {
        processOperation(.Multiply)
    }
    
    @IBAction func onMinusPressed(_ sender: UIButton) {
        processOperation(.Subtract)
    }
    
    @IBAction func onPlusPressed(_ sender: UIButton) {
        processOperation(.Add)
    }
    
    @IBAction func onEqualsPressed(_ sender: UIButton) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playBtnSound()
        
            if currentOperation != Operation.Empty {
                // Run Code
                
                
                // a user selected an operator and then another one
                if runningNumber != "" {
                    
                    rightValString = runningNumber
                    runningNumber = ""
                    
                    if currentOperation == Operation.Divide {
                        result = "\(Double(leftValString)! / Double(rightValString)!)"
                    } else if currentOperation == Operation.Multiply {
                        result = "\(Double(leftValString)! * Double(rightValString)!)"
                    } else if currentOperation == Operation.Add {
                        result = "\(Double(leftValString)! + Double(rightValString)!)"
                    } else if currentOperation == Operation.Subtract {
                        result = "\(Double(leftValString)! - Double(rightValString)!)"
                    }
                    
                    leftValString = result
                    outputLbl.text = result
                    
                }
                
                currentOperation = op
                
                
            } else {
                // First Run
                if (runningNumber == "") {
                    print("no numbers entered yet")
                } else {
                    leftValString = runningNumber
                    runningNumber = ""
                    currentOperation = op
                    print(currentOperation)
                }
                
            }
        
    }
    
    func playBtnSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    
}
