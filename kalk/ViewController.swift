//
//  ViewController.swift
//  kalk
//
//  Created by Kevin Wang on 2023-12-02.
//

import UIKit

class ViewController: UIViewController {
    // TODO: !!! shrink text as number gets bigger
    // or make it move to the right and like you swipe on the text to see the rest of the expression
    
    // TODO: add ANS (equal swipe down or smth)
    // TODO: change action to press release instead of press down
    // TODO: swipe gestures for cursor
    // TODO: add a 0 if only an operator is pressed
    // TODO: add like power sqrt and factorial etc on the numbers as 2nd function (2f is pressed)
    // TODO: 2f turn off once a button (any) is pressed
    // TODO: animate (esp. 2f color change)
    // TODO: potentially unbold the text
    
    var expression: String = "";

    @IBOutlet weak var subOut: UILabel!
    @IBOutlet weak var mainOut: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    var function = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainOut.layer.masksToBounds = true
        mainOut.layer.cornerRadius = 5
        subOut.layer.masksToBounds = true
        subOut.layer.cornerRadius = 5
    }
    
    // update both labels
    func updateLabels() {
        // TODO: **potentially** render divide ("/") and multiply ("*") as the division unicode symbol and the x symbol or smth
        subOut.text = expression;
        if (expression == "") {
            mainOut.text = "0"
        }
        
        if (function) {
            // update color of 2f button
            button1.backgroundColor = UIColor(cgColor: CGColor(red: 50, green: 40, blue: 0, alpha: 1));
            button1.layer.cornerRadius = 20
        }
        if (!function) {
            button1.backgroundColor = UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 0))
            button1.layer.cornerRadius = 20
        }
    }
    
    // method to calculate the answer
    func evaluate() {
        let res: MathParser = MathParser(string: expression)
        mainOut.text = String(res.parse())
        expression = ""
    }
    
    
    
    
    
    // the buttons
    @IBAction func button0AC(_ sender: Any) {
        // TODO: tap swipe down for delete char
        expression = ""
        updateLabels()
    }
    @IBAction func button1FUNCTION(_ sender: Any) {
        function = !function
        print(function)
        updateLabels()
    }
    @IBAction func button2OPENBRACKET(_ sender: Any) {
        expression += "("
        updateLabels()
    }
    @IBAction func button3CLOSEBRACKET(_ sender: Any) {
        expression += ")"
        updateLabels()
    }
    @IBAction func button4SIN(_ sender: Any) {
        expression += "sin("
        updateLabels()
    }
    @IBAction func button5COS(_ sender: Any) {
        expression += "cos("
        updateLabels()
    }
    @IBAction func button6TAN(_ sender: Any) {
        expression += "tan("
        updateLabels()
    }
    @IBAction func button7DIVIDE(_ sender: Any) {
        expression += "/"
        updateLabels()
    }
    @IBAction func button8SEVEN(_ sender: Any) {
        expression += "7"
        updateLabels()
    }
    @IBAction func button9EIGHT(_ sender: Any) {
        expression += "8"
        updateLabels()
    }
    @IBAction func button10NINE(_ sender: Any) {
        expression += "9"
        updateLabels()
    }
    @IBAction func button11MULTIPLY(_ sender: Any) {
        expression += "*"
        updateLabels()
    }
    @IBAction func button12FOUR(_ sender: Any) {
        expression += "4"
        updateLabels()
    }
    @IBAction func button13FIVE(_ sender: Any) {
        expression += "5"
        updateLabels()
    }
    @IBAction func button14SIX(_ sender: Any) {
        expression += "6"
        updateLabels()
    }
    @IBAction func button15SUBTRACT(_ sender: Any) {
        expression += "-"
        updateLabels()
    }
    @IBAction func button16ONE(_ sender: Any) {
        expression += "1"
        updateLabels()
    }
    @IBAction func button17TWO(_ sender: Any) {
        expression += "2"
        updateLabels()
    }
    @IBAction func button18THREE(_ sender: Any) {
        expression += "3"
        updateLabels()
    }
    @IBAction func button19ADD(_ sender: Any) {
        expression += "+"
        updateLabels()
    }
    @IBAction func button20ZERO(_ sender: Any) {
        expression += "0"
        updateLabels()
    }
    @IBAction func button21DECIMAL(_ sender: Any) {
        expression += "."
        updateLabels()
    }
    @IBAction func button22EQUAL(_ sender: Any) {
        evaluate()
    }
    

}

