//
//  MathParser.swift
//  kalk
//
//  Created by Kevin Wang on 2023-12-02.
//

import Foundation

//class MathParser {
//
//    private var pos = -1
//    private var ch: Character = " "
//    public var str: String
//    
//    init(string: String) {
//        str = string
//    }
//
//    private func nextChar() {
//        if pos < str.count - 1 {
//            pos += 1
//            ch = str[str.index(str.startIndex, offsetBy: pos)]
//        } else {
//            ch = Character("-")
//        }
//    }
//
//    private func eat(_ charToEat: Character) -> Bool {
//        while ch == " " {
//            nextChar()
//        }
//        if ch == charToEat {
//            nextChar()
//            return true
//        }
//        return false
//    }
//
//    func parse() -> String {
//        nextChar()
//        do {
//            let x = try parseExpression()
//            if pos < str.count {
//                throw MathError.err("Unexpected: \(ch)")
//            }
//            return String(x)
//        } catch MathError.err(let message){
//            return message
//        } catch {}
//        return ""
//    }
//
//    // Grammar:
//    // expression = term | expression `+` term | expression `-` term
//    // term = factor | term `*` factor | term `/` factor
//    // factor = `+` factor | `-` factor | `(` expression `)`
//    //        | number | functionName `(` expression `)`
//    //        | factor `^` factor
//
//    private func parseExpression() throws -> Double {
//        var x = try parseTerm()
//        while true {
//            if eat("+") {
//                x += try parseTerm() // addition
//            } else if eat("-") {
//                x -= try parseTerm() // subtraction
//            } else {
//                return x
//            }
//        }
//    }
//
//    private func parseTerm() throws -> Double {
//        var x = try parseFactor()
//        while true {
//            if eat("*") {
//                x *= try parseFactor() // multiplication
//            } else if eat("/") {
//                x /= try parseFactor() // division
//            } else {
//                return x
//            }
//        }
//    }
//
//    private func parseFactor() throws -> Double {
//
//        if eat("+") {
//            return try +parseFactor() // unary plus
//        }
//        if eat("-") {
//            return try -parseFactor() // unary minus
//        }
//
//        var x: Double
//        let startPos = pos
//        
//        if eat("(") {
//            x = try parseExpression()
//            if !eat(")") {
//                throw MathError.err("Missing ')'")
//            }
//
//        } else if ch >= "0" && ch <= "9" || ch == "." {
//            while ch >= "0" && ch <= "9" || ch == "." {
//                nextChar()
//            }
//            guard let number = Double(String(str[str.index(str.startIndex, offsetBy: startPos)...str.index(str.startIndex, offsetBy: pos)])) else {
//                throw MathError.err("Invalid number")
//            }
//            x = number
//            
//        } else if ch >= "a" && ch <= "z" {
//
//            while ch >= "a" && ch <= "z" {
//                nextChar()
//            }
////            guard let func_ = String(str[str.index(str.startIndex, offsetBy: startPos)...str.index(str.startIndex, offsetBy: pos)]) else {
////                throw MathError.err("Invalid function")
////            }
//            let func_ = String(str[str.index(str.startIndex, offsetBy: startPos)...str.index(str.startIndex, offsetBy: pos)])
//            
//            if eat("(") {
//                x = try parseExpression()
//                guard eat(")") else {
//                    throw MathError.err("Missing ')' after \(func_)")
//                }
//            } else {
//                x = try parseFactor()
//            }
//            
//            if func_ == "sin" {
//                x = sin(x)
//            } else if func_ == "cos" {
//                x = cos(x)
//            } else {
//                throw MathError.err("Unknown function \(func_)")
//            }
//            
//        } else {
//            throw MathError.err("Unexpected: \(ch)")
//        }
//
//        if eat("^") {
//            x = pow(x, try parseFactor())
//        }
//
//        return x
//    }
//
//}

enum MathError: Error {
    case err(String)
}


class MathParser {
    
    func rounds(x: Double) -> Double {
        return Double(round(10000000000 * x) / 10000000000)
    }
    
    var pos = -1
    var ch: Character = " "
    var str: String;
    
    init(string: String) {
        str = string
    }

    func nextChar() {
        pos += 1
        ch = (pos < str.count) ? str[str.index(str.startIndex, offsetBy: pos)] : Character(UnicodeScalar(0))
    }

    func eat(_ charToEat: Character) -> Bool {
        while ch == " " {
            nextChar()
        }
        if ch == charToEat {
            nextChar()
            return true
        }
        return false
    }

    func parse() throws -> Double {
        nextChar()
        let x = try parseExpression()
        if pos < str.count {
            throw MathError.err("Unexpected: \(ch)")
        }
        return x
    }

    // Grammar:
    // expression = term | expression `+` term | expression `-` term
    // term = factor | term `*` factor | term `/` factor
    // factor = `+` factor | `-` factor | `(` expression `)` | number
    //        | functionName `(` expression `)` | functionName factor
    //        | factor `^` factor

    func parseExpression() throws -> Double {
        var x = try parseTerm()
        while true {
            if eat("+") { x += try parseTerm() } // addition
            else if eat("-") { x -= try parseTerm() } // subtraction
            else { return x }
        }
    }

    func parseTerm() throws -> Double {
        var x = try parseFactor()
        while true {
            if eat("*") { x *= try parseFactor() } // multiplication
            else if eat("/") { x /= try parseFactor() } // division
            else { return x }
        }
    }

    func parseFactor() throws -> Double {
        if eat("+") { return try +parseFactor() } // unary plus
        if eat("-") { return try -parseFactor() } // unary minus

        var x: Double
        let startPos = self.pos
        if eat("(") { // parentheses
            x = try parseExpression()
            if !eat(")") { throw MathError.err("Missing ')'") }
        } else if (ch >= "0" && ch <= "9") || ch == "." { // numbers
            while (ch >= "0" && ch <= "9") || ch == "." { nextChar() }
            x = Double(str[str.index(str.startIndex, offsetBy: startPos)..<str.index(str.startIndex, offsetBy: self.pos)]) ?? 0
        } else if (ch >= "a" && ch <= "z") { // functions
            while ch >= "a" && ch <= "z" { nextChar() }
            let funcName = String(str[str.index(str.startIndex, offsetBy: startPos)..<str.index(str.startIndex, offsetBy: self.pos)])
            if eat("(") {
                x = try parseExpression()
                if !eat(")") { throw MathError.err("Missing ')' after argument to \(funcName)") }
            } else {
                x = try parseFactor()
            }
            let d2 = 3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282/180
            let d1 = 180/3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282
            switch funcName {
                // rounding to avoid floating point errors
            case "sqrt": x = rounds(x: Foundation.sqrt(x))
            case "sin": x = rounds(x: Foundation.sin(x * d2))
            case "cos": x = rounds(x: Foundation.cos(x * d2))
            case "tan": x = rounds(x: Foundation.tan(x * d2))
            case "asin": x = rounds(x: Foundation.asin(x) * d1)
            case "acos": x = rounds(x: Foundation.acos(x) * d1)
            case "atan": x = rounds(x: Foundation.atan(x) * d1)
            default: throw MathError.err("Unknown function: \(funcName)")
            }
        } else {
            throw MathError.err("Unexpected: \(ch)")
        }

        if eat("^") { x = Foundation.pow(x, try parseFactor()) } // exponentiation

        return x
    }
}
