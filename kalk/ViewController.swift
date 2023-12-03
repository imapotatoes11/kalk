//
//  ViewController.swift
//  kalk
//
//  Created by Kevin Wang on 2023-12-02.
//

import UIKit

class ViewController: UIViewController {
    // TODONE: !!! shrink text as number gets bigger
    
    // TODO: rework ui/ux esp. the colors
    // TODO: add ANS (equal swipe down or smth)
    // TODO: make it like add ANS if operator pressed first
    // TODO: change action to press release instead of press down
    // TODO: swipe gestures for cursor
    // TODO: add a 0 if only an operator is pressed
    // TODO: add like power sqrt and factorial etc on the numbers as 2nd function (2f is pressed)
    // TODO: 2f turn off once a button (any) is pressed
    // TODO: animate (esp. 2f color change)
    // TODO: potentially unbold the text
    // TODO: maybe light mode??? but finish the 2f first
    
    var expression: String = "";

    @IBOutlet weak var subOut: UILabel!
    @IBOutlet weak var mainOut: UILabel!
    
    // define constants
    let subOutMaxLines = 2
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    var function = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainOut.layer.masksToBounds = true
        mainOut.layer.cornerRadius = 5
        subOut.layer.masksToBounds = true
        subOut.layer.cornerRadius = 5
        
        subOut.adjustsFontSizeToFitWidth = true
        subOut.minimumScaleFactor = 0.5
        mainOut.adjustsFontSizeToFitWidth = true
        subOut.minimumScaleFactor = 0.5
        
        for i in [button4, button5, button6] {
            i?.titleLabel?.adjustsFontSizeToFitWidth = true
            i?.titleLabel?.minimumScaleFactor = 0.5
        }
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
        }; if (!function) {
            button1.backgroundColor = UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 0))
            button1.layer.cornerRadius = 20
        }
        
        // update function buttons
        if function {
            button4.setTitle("asin", for: button4.state)
            button5.setTitle("acos", for: button5.state)
            button6.setTitle("atan", for: button6.state)
        }
        if !function {
            button4.setTitle("sin", for: button4.state)
            button5.setTitle("cos", for: button5.state)
            button6.setTitle("tan", for: button6.state)
        }
        
        
        
        // truncate by head
        subOut.lineBreakMode = .byTruncatingHead
        if expression.count % 20 >= 19 {
            subOut.numberOfLines += 1
        }
//        print("------------------------------------")
//        print("exp.count \(expression.count)")
//        print("subOut.numOfLines \(subOut.numberOfLines)")
//        print("count%20: \(expression.count % 20)")
        
        // undo actions if limit of 2 lines is reached
        if /*expression.count % 20 >= 19 &&*/ subOut.numberOfLines > subOutMaxLines {
            // TODO: multiply like shrinks it cuz kerning
            expression = String(expression.dropLast(1))
            subOut.numberOfLines = subOutMaxLines
            // re-update labels
            updateLabels()
        }
    }
    
    // method to calculate the answer
    func evaluate() {
        do {
            let res: MathParser = MathParser(string: expression)
            mainOut.text = try String(res.parse())
            expression = ""
        } catch MathError.err(let msg) {
            expression = ""
            mainOut.text = "\(msg)"
            subOut.text = ""
        } catch {}
    }
    
    
    
    // the buttons
    @IBAction func button0AC(_ sender: Any) {
        // TODO: tap swipe down for delete char
        expression = ""
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
    }
    @IBAction func button1FUNCTION(_ sender: Any) {
        function = !function
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button2OPENBRACKET(_ sender: Any) {
        expression += "("
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button3CLOSEBRACKET(_ sender: Any) {
        expression += ")"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button4SIN(_ sender: Any) {
        if !function {
            expression += "sin("
        } else {
            expression += "asin("
            function = false
        }
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button5COS(_ sender: Any) {
        if !function {
            expression += "cos("
        } else {
            expression += "acos("
            function = false
        }
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button6TAN(_ sender: Any) {
        if !function {
            expression += "tan("
        } else {
            expression += "atan("
            function = false
        }
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button7DIVIDE(_ sender: Any) {
        expression += "/"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button8SEVEN(_ sender: Any) {
        expression += "7"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button9EIGHT(_ sender: Any) {
        expression += "8"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button10NINE(_ sender: Any) {
        expression += "9"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button11MULTIPLY(_ sender: Any) {
        expression += "*"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button12FOUR(_ sender: Any) {
        expression += "4"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button13FIVE(_ sender: Any) {
        expression += "5"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button14SIX(_ sender: Any) {
        expression += "6"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button15SUBTRACT(_ sender: Any) {
        expression += "-"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button16ONE(_ sender: Any) {
        expression += "1"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button17TWO(_ sender: Any) {
        expression += "2"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button18THREE(_ sender: Any) {
        expression += "3"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button19ADD(_ sender: Any) {
        expression += "+"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button20ZERO(_ sender: Any) {
        expression += "0"
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button21DECIMAL(_ sender: Any) {
        expression += "."
        updateLabels()
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    @IBAction func button22EQUAL(_ sender: Any) {
        if expression != "" {
            evaluate()
            let impact = UIImpactFeedbackGenerator(style: .heavy)
            impact.impactOccurred()
        } else {
            print("expression was empty")
            let impact = UIImpactFeedbackGenerator(style: .rigid)
            impact.impactOccurred()
        }
    }
    

}

