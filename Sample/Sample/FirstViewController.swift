//
//  FirstViewController.swift
//  Sample
//
//  Created by Alexandra on 12/6/19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let gradient = CAGradientLayer()
//
//        gradient.frame = view.bounds
//        gradient.colors = [UIColor.black.cgColor, UIColor.purple.cgColor,UIColor.black.cgColor]
//
//        view.layer.insertSublayer(gradient, at: 0)
        view.backgroundColor = UIColor.cyan
        
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
        var cH: [() -> Void] = []
        func some( handler : @escaping () -> Void){
            cH.append(handler)
        }
        
        func any(handler : () -> Void){
            handler()
        }
        
        some{
            print("I want to escape")
        }
        any{
            print("I don't want to escape")
        }
        cH[0]()
        
        
        
        
        
    }
    


}
