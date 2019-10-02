//
//  Calc.swift
//  Calc MVC
//
//  Created by Alexandra on 16.09.19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import Foundation

class Calcbase{
    var firstval:Float = 0.0
    var secondval:Float? = nil
    var oper:String = ""
    
    
    func calculate() ->Bool {
        
        if(self.secondval==nil){
            self.secondval=self.firstval
        }
        print("f:\(firstval) \(oper) s:\(secondval!)")
        switch self.oper {
        case "+":
            self.firstval=self.firstval+self.secondval!
            return true
        case "-":
            firstval=firstval-secondval!
            return true
        case "*":
            firstval=firstval*secondval!
            return true
        case "/":
            if(secondval! > 0){
                firstval=firstval/secondval!
                return true
            }
            firstval=0
            secondval=0
            oper=""
            return false
            
        default:
            print("f:\(firstval) s:\(secondval!)")
    }
        return false
    
}
    func change(op:String,val:String)->String!{
        var res=val
        var a=Float(res)!
        switch(op){
        case "+/-":
            a=a*(-1)
        case "x^2":
            a=a*a
        case "1/x":
            if(a != 0){
                a=1/a
            }else{
                res="Error"
            }
        case "√x":
            if(a>=0){
                a=Float(sqrt(Double(a)))
            }else{
                res="Error"
            }
        
        default:
            print(res)
        }
        if(!res.contains("Error")){
            if a.remainder(dividingBy: 1)==0{
                res=String(Int(a))
                
            }else{
                res=String(a)
                
            }
        }
        return res
    }
    
        
        
}

