//
//  ViewController.swift
//  Numbers API
//
//  Created by Alexandra on 26.09.19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var number: UITextField!
    var types:[String]=["MATH","YEAR","TRIVIA","RANDOM"]
    var count=0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        number.layer.borderWidth=1
        number.layer.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5158175616)
        number.layer.borderColor=UIColor.white.cgColor
        number.layer.cornerRadius=10
        number.font=UIFont(name: "Avenir Next", size: 25)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "/Users/alexandra/Desktop/88.jpg")!)
        first.layer.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.351837588)
        first.layer.borderColor=UIColor.white.cgColor
        first.layer.cornerRadius=10
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! UITableViewCell
        
        cell.layer.borderColor=UIColor.white.cgColor
        cell.layer.borderWidth=2
        cell.layer.cornerRadius=10
        cell.textLabel?.text="\(types[count]) FACT"
        cell.textLabel?.textColor=UIColor.white
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font=UIFont(name: "Avenir Next", size: 25)
        count=count+1
        if count==types.count{
            count=0
        }
        
        
        
        
    
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = tableView.cellForRow(at: indexPath) as! UITableViewCell
        if(number.text!.count>0){
            cell.isUserInteractionEnabled = true
           
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "second") as! SecondViewController
            
           
            
            vc.number = number.text!
            vc.type=cell.textLabel!.text!.lowercased().components(separatedBy: " ")[0]
            
            
            self.present(vc, animated: true, completion: nil)
        }else{
            cell.isUserInteractionEnabled = false
            
            cell.isUserInteractionEnabled=true
            
        }
    }


    
}

