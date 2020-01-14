//
//  FirstViewController.swift
//  Sample
//
//  Created by Alexandra on 12/6/19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import UIKit


enum Products: String, CaseIterable{
    case bread = "hhh"
    case water = "vvv"
}

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let gradient = CAGradientLayer()
//
//        gradient.frame = view.bounds
//        gradient.colors = [UIColor.black.cgColor, UIColor.purple.cgColor,UIColor.black.cgColor]
//
//        view.layer.insertSublayer(gradient, at: 0)
        view.backgroundColor = UIColor.yellow
        
//        var a = 25
//        var b = 2
//        let my : () -> Int = {[a] in
//            return a * b}
//        print(my())
//        a = 20
//        b = 4
//
//        print(my())
//        var names: [String] = ["Alex", "Roma", "Meruert"]
//        print(names.count)
//        let removing = { names.removeFirst()}
//        print(names.count)
//        print("Now remove : \(removing())")
//        print(names.count)
//        var cH: [() -> Void] = []
//        func some( handler : @escaping () -> Void){
//            cH.append(handler)
//        }
//
//        func any(handler : () -> Void){
//            handler()
//        }
//
//        some{
//            print("I want to escape")
//        }
//        any{
//            print("I don't want to escape")
//        }
//        cH[0]()
        
        let input:String = "sum (1) (26) (38)"
        print(input.data(using: .utf8)?.base64EncodedString())
//        let mapped: [Int?] = input.map { num in Int(String(num)) }
//        print(mapped)
        print(sumOfString(input: input))
//        print(Products.allCases.count)
//        print(Products.bread.rawValue)
        
//        var t = Table()
//
//        print(type(of: t.chair))
//        if let i = t.chair{
//            print(type(of: i))
//        }else{
//            print("oops")
//        }
        
        
        
    
        
    }
    
    
    func sumOfString(input:String) -> Int{
        let arr = input.split(separator: " ")
        var sum: Int! = 0
        for i in arr {
            var ii = i
            ii.removeFirst()
            ii.removeLast()
            if let num = Int(ii) {
                print(num)
                sum += num
            }else{
                print("not a number")
            }

        }
        return sum
    }
    


}
