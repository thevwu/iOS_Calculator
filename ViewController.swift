//
//  ViewController.swift
//  Calculator
//
//  Created by Victor Wu on 3/18/16.
//  Copyright © 2016 wayfair. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let calculator = Calculator.sharedInstance
    
    @IBOutlet weak var outputLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        calculator.addNumber(sender.currentTitle!)
        self.updateOutput()
    }
    
    @IBAction func clearOutput(sender: UIButton) {
        calculator.clearOutput()
        self.updateOutput()
    }
    
    @IBAction func addOperation(sender: UIButton) {
        calculator.addOperation(sender.currentTitle!)
        self.updateOutput()
    }
    
    @IBAction func calculate(sender: UIButton) {
        calculator.doEquals()
        self.updateOutput()
    }
    
    @IBAction func changeSign(sender: UIButton) {
        calculator.changeSign()
        self.updateOutput()
    }
    
    @IBAction func percent(sender: UIButton) {
        calculator.percent()
        self.updateOutput()
    }
    
    @IBAction func addDecimal(sender: UIButton) {
        calculator.addDecimal()
        self.updateOutput()
    }
    
    private func updateOutput() {
        let newOutput = calculator.getCurrentOutput()
        outputLabel.text = newOutput
    }
}

