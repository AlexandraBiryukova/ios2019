//
//  NewPostViewController.swift
//  Arbook
//
//  Created by Alexandra on 12/1/19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage
import CoreData

class NewPostViewController: UIViewController {
    let storage = Storage.storage()
    var ref: DatabaseReference!
    var storageRef:StorageReference! = nil
    public var image_address: String = ""
    
    public lazy var imageC:UIImageView = {
        let imageV = UIImageView()
        imageV.clipsToBounds = true
        imageV.layer.cornerRadius=16
//        imageV.layer.borderWidth = 1
//        imageV.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageV.image = UIImage (named:"AppIcon")
        imageV.layer.backgroundColor = #colorLiteral(red: 0.9658331902, green: 0.9821088488, blue: 1, alpha: 0.3014139525)
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()
    
    public lazy var titl: UILabel = {
        let button = UILabel()
        button.font=UIFont(name: "Avenir Next", size: 20)
        button.textColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        button.text="POST TITLE"
        return button
    }()
    
    public lazy var desc: UILabel = {
        let button = UILabel()
        button.font=UIFont(name: "Avenir Next", size: 20)
        button.textColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        button.text="POST TEXT"
        return button
    }()
    
    public lazy var textP: UITextView = {
        let button = UITextView()
        button.font=UIFont(name: "Avenir Next", size: 17)
        button.textColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderColor = #colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor.clear
        button.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return button
    }()
    
    public lazy var titlP: UITextView = {
        let button = UITextView()
        button.font=UIFont(name: "Avenir Next", size: 17)
        button.textColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderColor = #colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor.clear
        button.textContainerInset = UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16)
        return button
    }()
    
    public lazy var chooseIm: UIButton = {
        let button = UIButton()
        button.titleLabel?.font=UIFont(name: "Avenir Next", size: 17)
        button.backgroundColor=UIColor.clear
        button.layer.cornerRadius = 16
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle("Choose image", for: .normal)
        button.addTarget(self,action: #selector(chIm), for: .touchUpInside)
        return button
    }()
    
    public lazy var savePost: UIButton = {
        let button = UIButton()
        button.titleLabel?.font=UIFont(name: "Avenir Next", size: 17)
        button.setTitleColor(UIColor.white ,for: .normal)
        button.backgroundColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        button.layer.cornerRadius=16
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Upload post", for: .normal)
        button.addTarget(self,action: #selector(save), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=#colorLiteral(red: 0.08217292746, green: 0.08217292746, blue: 0.08217292746, alpha: 1)
        self.title="New post"
        ref=Database.database().reference()
        self.storageRef = self.storage.reference()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),NSAttributedString.Key.font:UIFont(name: "Avenir Next", size: 21)!]
        self.navigationController?.navigationBar.barTintColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        self.navigationController?.navigationBar.tintColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        markup()
    }
    
    @objc func save(){
        if(titlP.text != "" && textP.text != "" && image_address != ""){
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd.MM.yy"
            let date = dateFormatterPrint.string(from: Date())
//            print("I'm starting")
            let cachePost = CachePost(context: AppDelegate.persistentContainer.viewContext)
            cachePost.desc = textP.text!
            cachePost.image = image_address
//            print("ok1")
            cachePost.owner = (Auth.auth().currentUser?.phoneNumber! as! String)
            cachePost.likes = Int64(0)
            cachePost.title = titlP.text!
            cachePost.upload_date = date
//            print("end instance")
            
            do{
//                print("st1")
                try AppDelegate.persistentContainer.viewContext.save()
                let vc = MyPostsViewController()
                var P: Post=Post()
                P.description = cachePost.desc
                P.image = cachePost.image
                P.likes = 0
                P.title = cachePost.title
                P.upload_date = cachePost.upload_date
                P.image = cachePost.image
                vc.posts.append(P)
//                print("st2")
            }catch{
                print(error)
            }
//            print("st3")
            self.ref.child("posts").childByAutoId().setValue(["description": textP.text!, "image" : image_address, "owner": (Auth.auth().currentUser?.phoneNumber! as! String),"likes": 0 as! Int, "title":  titlP.text! ,"upload_date":date])
            self.navigationController?.popViewController(animated: true)
        }else{
            let alert = UIAlertController(title: "Oops...", message: "Post can be saved only if you choose image, title and text. Please fill all fields and choose image.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  switch action.style{
                  case .default:
                        print("default")

                  case .cancel:
                        print("cancel")

                  case .destructive:
                        print("destructive")


            }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func chIm(){
        var vc = ChooseImageViewController()
        vc.callBack = { (image:UIImage,addr:String) in
            self.imageC.image=image
            self.image_address = addr
//            print(addr)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    func markup(){
        [chooseIm,imageC,titl,desc,textP,titlP,savePost].forEach { view.addSubview($0) }
        imageC.snp.makeConstraints() {
            $0.top.equalTo(view.snp.topMargin).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(200)
            $0.width.equalTo(200)
        }
        chooseIm.snp.makeConstraints() {
            $0.top.equalTo(view.snp.topMargin).offset(100)
            $0.left.equalTo(imageC.snp.right).offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
        savePost.snp.makeConstraints() {
            $0.top.equalTo(textP.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
        titl.snp.makeConstraints() {
            $0.top.equalTo(imageC.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(32)
        }
        titlP.snp.makeConstraints() {
            $0.top.equalTo(titl.snp.bottom).offset(4)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
        desc.snp.makeConstraints() {
            $0.top.equalTo(titlP.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(32)
        }
        textP.snp.makeConstraints() {
            $0.top.equalTo(desc.snp.bottom).offset(4)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(240)
        }
    }
}
