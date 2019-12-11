//
//  PostViewController.swift
//  Arbook
//
//  Created by Alexandra on 12/1/19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseUI
import FirebaseStorage
class PostViewController: UIViewController {
    var likedPosts: [String] = []
    var curPostKey: String = ""
    var storageRef:StorageReference! = nil
    var ref: DatabaseReference!
    public lazy var imageOf:UIImageView = {
        let imageV = UIImageView()
        imageV.clipsToBounds = true
        return imageV
    }()
    
    public lazy var titl: UILabel = {
        let button = UILabel()
        button.font=UIFont(name: "Avenir Next", size: 30)
        button.textColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        button.numberOfLines = 3
        return button
    }()
    
    public lazy var desc: UITextView = {
        let button = UITextView()
        button.font=UIFont(name: "Avenir Next", size: 20)
        button.textColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.backgroundColor=#colorLiteral(red: 0.08217292746, green: 0.08217292746, blue: 0.08217292746, alpha: 1)
        button.isScrollEnabled=true
        button.isEditable = false
        return button
    }()
    
    public lazy var likes: Heart = {
        let button = Heart()
        button.titleLabel?.font=UIFont(name: "Avenir Next", size: 17)
        button.setTitleColor(UIColor.white ,for: .normal)
        button.addTarget(self, action: #selector(likeClicked), for: .touchUpInside)
        button.setImage(UIImage(named: "white"), for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 16
        return button
    }()
    
    
    public lazy var date: UILabel = {
        let button = UILabel()
        button.font=UIFont(name: "Avenir Next", size: 17)
        button.textColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return button
    }()
    
    public lazy var owner: UILabel = {
       let button = UILabel()
       button.font=UIFont(name: "Avenir Next", size: 17)
       button.textColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
       return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.accessibilityScroll(.down)
//        self.accessibilityScroll(.up)
         navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named: "Image"), style: .plain, target: self , action: #selector(shareFunc))
        self.view.backgroundColor=#colorLiteral(red: 0.08217292746, green: 0.08217292746, blue: 0.08217292746, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,NSAttributedString.Key.font:UIFont(name: "Avenir Next", size: 21)!]
        self.navigationController?.navigationBar.barTintColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        self.navigationController?.navigationBar.tintColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        loadPost()
        markup()
    }
    
    @objc private func shareFunc(){
        let shareText = self.desc.text
        let image = self.imageOf.image
//
        let items = [image,shareText] as [Any]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    
    private func loadPost(){
//        print(self.curPostKey)
        self.ref.child("posts").child(self.curPostKey).observeSingleEvent(of: .value, with: { (snapshot) in
            let el = snapshot.value as? NSDictionary
            let elTitle = el!["title"] as! String
            let elDescription = el!["description"] as! String
            let elLikes = el!["likes"] as! Int
            let elDate = el!["upload_date"] as! String
            let elOwner = el!["owner"] as! String
            let imageUrlString = el!["image"] as! String
            let reference = self.storageRef.child(imageUrlString)
            self.imageOf.sd_setImage(with:  reference)
            self.title = elTitle
            self.titl.text = elTitle.uppercased()
                
    //            var found: Bool = false
    //            print("Start")
            self.likes.setTitle("\(elLikes)", for: .normal)
            self.likes.setImage(UIImage(named: "white"), for: .normal)
            self.likes.layer.borderColor = UIColor.white.cgColor
            
            for postKey in self.likedPosts{
                if(self.curPostKey==postKey){
                    self.likes.setTitle("\(elLikes)", for: .normal)
                    //self.likes.isSelected = true
                    self.likes.setImage(UIImage(named: "red"), for: .normal)
                    self.likes.layer.borderColor = UIColor.red.cgColor
                    self.likes.setTitleColor(UIColor.white, for: .normal)
                    break
                }
//                print(postKey)
            }
            self.date.text = "Uploaded on \(elDate)"
            self.desc.text = elDescription
                
            self.ref.child("users").child(elOwner).observeSingleEvent(of: .value, with: { (snap) in
                var username = "Unknown"
                let userInstance = snap.value as? NSDictionary
                username = userInstance?["name"] as? String ?? ""
                self.owner.text="Author: \(username)"
                
            })
            
        }) { (error) in
            print(error.localizedDescription)
            
        }
        
    }
    @objc private func likeClicked(sender: UIButton){
        self.ref.child("posts").child(self.curPostKey).observeSingleEvent(of: .value, with: {
            (snapshot) in
            var updatedElement = snapshot.value as? NSDictionary
    
            var found = false
            for postKey in self.likedPosts{
                if(self.curPostKey==postKey){
                    found = true
//                    print(found)
                    break
                }
            }
            
            if(found==false){
                self.likes.isEnabled = true
                let newLikes = ((updatedElement!["likes"] as! Int) + 1)
                updatedElement!.setValue((newLikes), forKey: "likes")
                self.ref.child("posts/\(self.curPostKey)/likes").setValue((newLikes))
                let childUpdates = ["/users/\((Auth.auth().currentUser?.phoneNumber!)!)/posts/\(self.curPostKey)": updatedElement]
                self.ref.updateChildValues(childUpdates)
//                self.likes.setTitle("❤️ \(newLikes)", for: .normal)
                self.likes.setImage(UIImage(named: "red"), for: .normal)
                self.likes.setTitle("\(newLikes)", for: .normal)
                self.likes.layer.borderColor = UIColor.red.cgColor
//                self.likes.setTitleColor(UIColor.white, for: .normal)
                self.likedPosts.append(self.curPostKey)
//                print(self.likedPosts)
            }else{
                self.likes.isEnabled = true
                let newLikes = ((updatedElement!["likes"] as! Int) - 1)
                self.ref.child("users").child((Auth.auth().currentUser?.phoneNumber)!).child("posts").child("\(self.curPostKey)").removeValue()
                self.ref.child("posts/\(self.curPostKey)/likes").setValue(newLikes)
//                self.likes.setTitle("🖤 \(newLikes)", for: .normal)
                self.likes.setImage(UIImage(named: "white"), for: .normal)
                self.likes.setTitle("\(newLikes)", for: .normal)
                self.likes.layer.borderColor = UIColor.white.cgColor
                
//                self.likes.setTitleColor(UIColor.black, for: .normal)
                
                var newLiked: [String] = []
                for j in self.likedPosts{
                    if(j != self.curPostKey){
                        newLiked.append(j)
//                        print(j)
                    }
                }
                
                
                self.likedPosts = newLiked
            }
        })
        self.likes.isEnabled = false
    }
    
    func markup(){
        [imageOf,date,owner,likes, desc,titl].forEach { view.addSubview($0) }
        imageOf.snp.makeConstraints() {
            $0.top.equalTo(view.snp.topMargin)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(250)
        }
        titl.snp.makeConstraints(){
            $0.top.equalTo(imageOf.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalTo(likes.snp.right).offset(-96)
        }
        likes.snp.makeConstraints(){
            $0.top.equalTo(imageOf.snp.bottom).offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalTo(70)
            $0.height.equalTo(40)
        }
        date.snp.makeConstraints(){
            $0.top.equalTo(titl.snp.bottom).offset(4)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalTo(likes.snp.right).offset(-16)
        }
        owner.snp.makeConstraints(){
            $0.top.equalTo(date.snp.bottom).offset(4)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalTo(likes.snp.right).offset(-16)
        }
        desc.snp.makeConstraints(){
            $0.top.equalTo(owner.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalTo(likes.snp.right).offset(-16)
            $0.bottom.equalTo(view.snp.bottom)
        }
    }
}
