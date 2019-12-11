//
//  ProfileViewController.swift
//  Arbook
//
//  Created by Alexandra on 12/2/19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import UIKit
import FirebaseAuth
import Crashlytics
import FirebaseDatabase

class ProfileViewController: UIViewController {
    var ref: DatabaseReference!
    
    public lazy var imageOf:UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named:"Image-3")
        return imageV
    }()
    public lazy var ph: UILabel = {
        let button = UILabel()
        button.font=UIFont(name: "Avenir Next", size: 20)
        button.textColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderColor = #colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        button.layer.borderWidth = 2
        button.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.67)
        button.layer.cornerRadius=16
        return button
        
    }()
    public lazy var name: UILabel = {
        let button = UILabel()
        button.font=UIFont(name: "Avenir Next", size: 20)
        button.textColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderColor = #colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        button.layer.borderWidth = 2
        button.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6723151408)
        button.layer.cornerRadius=16
        button.text = "  Username:"
        return button
        
    }()
    public lazy var logOutB: UIButton = {
        let button = UIButton()
        button.titleLabel?.font=UIFont(name: "Avenir Next", size: 17)
        button.setTitleColor(UIColor.white ,for: .normal)
        button.backgroundColor=#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        button.layer.cornerRadius=16
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Log out", for: .normal)
        button.addTarget(self,action: #selector(logOut), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addBackground()
        ref=Database.database().reference()
        self.navigationController?.navigationBar.titleTextAttributes =
                  [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,
                   NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 21)!]
        self.navigationController?.navigationBar.barTintColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        var phone = (Auth.auth().currentUser?.phoneNumber)!
        self.ph.text="  Phone number: \(phone)"
        self.ref.child("users").child(phone).observeSingleEvent(of: .value, with: { (snap) in
            var username = "Unknown"
            let userInstance = snap.value as? NSDictionary
            username = userInstance?["name"] as? String ?? ""
            self.name.text="  Username: \(username)"
            
        })
        markup()
        

        
    }
//    @objc func crashButtonTapped(_ sender: AnyObject) {
//        Crashlytics.sharedInstance().crash()
//    }
    
    @objc func logOut(){
        let alert = UIAlertController(title: "Are you sure?", message: "Click CANCEL if you touched this button by mistake.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "LOG OUT", style: .default, handler: { action in
              switch action.style{
              case .default:
                try? Auth.auth().signOut()
                var vc = AuthViewController()
                UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: AuthViewController())
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")


        }}))
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { action in
              switch action.style{
              case .default:
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")


        }}))
        self.present(alert, animated: true, completion: nil)
//        try? Auth.auth().signOut()
//        var vc = AuthViewController()
//        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: AuthViewController())
    }
    func markup(){
        view.addSubview(ph)
        view.addSubview(name)
        view.addSubview(imageOf)
        view.addSubview(logOutB)
        imageOf.snp.makeConstraints(){
            $0.top.equalTo(view.snp.topMargin).offset(16)
            $0.left.equalToSuperview().offset(130)
            $0.right.equalToSuperview().offset(-130)
            $0.height.equalTo(150)
        }
        ph.snp.makeConstraints(){
            $0.top.equalTo(name.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
        name.snp.makeConstraints(){
            $0.top.equalTo(imageOf.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
//        let button = UIButton(type: .roundedRect)
//        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
//        button.setTitle("Crash", for: [])
//        button.addTarget(self, action: #selector(self.crashButtonTapped), for: .touchUpInside)
//        view.addSubview(button)
//        button.snp.makeConstraints(){
//           $0.top.equalTo(logOutB.snp.bottom).offset(48)
//           $0.left.equalToSuperview().offset(16)
//           $0.right.equalToSuperview().offset(-16)
//        }
        
        logOutB.snp.makeConstraints(){
            $0.top.equalTo(ph.snp.bottom).offset(64)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
    }
}
