//
//  ViewController.swift
//  Calc MVC
//
//  Created by Alexandra on 16.09.19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var my_label: UILabel!
    var anyOper=false
    var wasOper=false
    var equal=false
    var c=Calcbase()
    
    
    @IBOutlet var buttons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "/Users/alexandra/Desktop/1.jpg")!)
        
        for item in buttons {
            item.layer.cornerRadius=15
            item.layer.borderColor=#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            item.layer.borderWidth=2
        }
        my_label.layer.cornerRadius=20
        my_label.layer.borderWidth=2
        my_label.layer.borderColor=#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        my_label.layer.masksToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func number(_ sender: UIButton) {
//        c.firstval=Float(sender.titleLabel!.text!)
//        print(c.firstval!.remainder(dividingBy: 1))
//        if c.firstval!.remainder(dividingBy: 1)==0{
//        my_label.text="\(Int(c.firstval!))"
//        }
        if(wasOper||equal){
            my_label.text=""
            wasOper=false
            equal=false
        }
        if (my_label.text=="0" || my_label.text=="Error"){
            my_label.text=sender.titleLabel!.text
        }else{my_label.text?.append(sender.titleLabel?.text ?? "")  }
        
    
    }
    @IBAction func cancel(_ sender: Any) {
        if(my_label.text!.count>1){
            if(equal||wasOper){
                my_label.text="0"
                if(equal){
                    c.firstval=0
                }
            }else{
            
            my_label.text?.removeLast()
                
            }
        }
        else{
            my_label.text="0"
        }
    }
    
    @IBAction func operation(_ sender: UIButton) {
        if(my_label.text=="Error"){
            c.firstval=0
            my_label.text="0"
    }else{
        c.firstval=Float(my_label.text!)!
    }
        c.oper=sender.titleLabel!.text!
        anyOper=true
        wasOper=true
    }
    @IBAction func result(_ sender: UIButton) {
        if anyOper{
            c.secondval=Float(my_label.text!)!
        }
        if !wasOper && !anyOper && !equal{
            c.firstval=Float(my_label.text!)!
        }
        
        if (c.calculate()){
            print(c.firstval)
        if c.firstval.remainder(dividingBy: 1)==0{
            my_label.text="\(Int(c.firstval))"
        }else{
             my_label.text="\(c.firstval)"
        }
        }else{
            my_label.text="Error"
        }
        anyOper=false
        equal=true
        
    }
    
    @IBAction func OneParam(_ sender: UIButton) {
        if(!my_label.text!.contains("Error")){
            var o:String!=sender.titleLabel!.text!
            my_label.text!=c.change(op: o,val: my_label.text!)
            wasOper=false
            equal=false
        }
    }
        

}

