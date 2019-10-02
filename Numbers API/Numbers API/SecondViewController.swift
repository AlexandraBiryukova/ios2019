//
//  SecondViewController.swift
//  Numbers API
//
//  Created by Alexandra on 26.09.19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController{
    var number:String = ""
    var type:String=""

    @IBOutlet weak var fact: UILabel!
    @IBOutlet weak var number_label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        number_label.text=number
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "/Users/alexandra/Desktop/88.jpg")!)
        downloadFact()
        fact.layer.cornerRadius=30
         number_label.layer.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5158175616)
         fact.layer.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5158175616)
        number_label.layer.cornerRadius=30
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func move_back(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "first")
        
        present(vc, animated: true)
    }
    func downloadFact() {
        print(self.number + " " + self.type)
        Fact.downloadFact(for: type, for: number) { [weak self] fact in
           
            self?.fact.text = fact.value
        }
    }
  

}
