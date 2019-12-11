//
//  HomeViewController.swift
//  Arbook
//
//  Created by Alexandra on 11/20/19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseUI
import SnapKit
import FirebaseAnalytics

class HomeViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    var ref: DatabaseReference!
    let storage = Storage.storage()
    var storageRef:StorageReference! = nil
    var likedPosts: [String] = []
    var posts:[Post] = []
    
// Search
    let userSearch: String = "трамп"
    
// Search
    
    
    public lazy var titlP: UITextView = {
        let button = UITextView()
        button.font=UIFont(name: "Avenir Next", size: 17)
        button.textColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderColor = #colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor.clear
        button.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 10, right: 16)
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
        button.setTitle("Find", for: .normal)
        button.addTarget(self,action: #selector(findEverywhere), for: .touchUpInside)
        return button
    }()
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 200
        view.estimatedRowHeight = 300
        view.backgroundColor=UIColor.clear
        view.tableFooterView = UIView(frame: .zero)
        view.layer.cornerRadius = 16
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        view.register(PostTableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        Analytics.logEvent(AnalyticsEventLogin, parameters: [
            AnalyticsParameterMethod: method
        ])
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(title!)",
            AnalyticsParameterItemName: title!,
            AnalyticsParameterContentType: "cont"
        ])
        
        navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named: "Image-1"), style: .plain, target: self , action: #selector(addNew))
        self.navigationController?.navigationBar.tintColor=UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,
             NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 21)!]
        self.navigationController?.navigationBar.barTintColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        
        self.storageRef = self.storage.reference()
        tableView.delegate = self
        tableView.dataSource = self
        ref=Database.database().reference()
        
        
        let phone = Auth.auth().currentUser?.phoneNumber
        self.ref.child("users").observeSingleEvent(of: .value, with: {DataSnapshot in
            let all = DataSnapshot.value as? NSDictionary
            if(all![phone]==nil){
                self.ref.child("users").child(phone!).setValue(["name": "New"])
            }
        })
        downloadPosts()
//        search(text: "Paris 2019", pattern: "Paris")
//        search(text: "новым президентом стал Трамп" , pattern:"Трамп")
//        search(text:"The big dog jumped over the fox", pattern:"over")
//        findNews(userSearch: self.userSearch)
        markup()
        
    }
    
    @objc func findEverywhere(){
//        print("here")
        var l:[Post] = []
        if (self.titlP.text == "") {
            downloadPosts()
            return
        }
        for post in posts{
            if((try? search(text: (" \(post.title) "), pattern: self.titlP.text)) != -1){
                post.fnd = true
                l.append(post)
            }
        }
        
        self.posts = l
        self.tableView.reloadData()
        
    }
    
    func findEverywhereUnclicked(){
//        print("here")
        var l:[Post] = []
        for post in posts{
            if((try? search(text: (" \(post.title) "), pattern: self.titlP.text)) != -1){
                post.fnd = true
                l.append(post)
            }
        }
        self.posts = l
        self.tableView.reloadData()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PostTableViewCell
        let vc = PostViewController()
        vc.likedPosts = self.likedPosts
        
        self.ref.child("posts").observeSingleEvent(of: .value, with: { (snapshot) in
           
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for i in result{
                    let el = i.value! as! NSDictionary
                    if(cell.titl.text == (el["title"]! as! String)){
                        vc.curPostKey = i.key
                        vc.ref = self.ref
                        vc.storageRef = self.storageRef
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    }
                }
            }
            
        })
    }
    
    func btnClicked(){
        self.findEverywhere()
//        self.viewDidLoad()
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        cell.backgroundColor=UIColor.clear
        cell.titl.text=self.posts[indexPath.section].title
        cell.desc.text=self.posts[indexPath.section].description
        cell.date.text=self.posts[indexPath.section].upload_date
        let imageUrlString = self.posts[indexPath.section].image
        let reference = self.storageRef.child(imageUrlString)
        cell.imageOf.sd_setImage(with:  reference)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.posts.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor=UIColor.clear
    }
//    @objc func nextMyPosts(sender: UIButton){
//        let vc = MyPostsViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    @objc func nextLikedPosts(sender: UIButton){
//        let vc = LikedPostsViewController()
//        print("helloStupid")
//        vc.likedPosts = self.likedPosts
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    @objc func addNew(){
        var vc = NewPostViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        downloadPosts()
        self.titlP.text = ""
//        findEverywhereUnclicked()
//        findEverywhere()
    }
    func downloadLikedPostsKeys(){
        self.likedPosts=[]
        self.ref.child("users").child((Auth.auth().currentUser?.phoneNumber!)!).child("posts").observeSingleEvent(of: .value, with: {DataSnapshot in
            if let result = DataSnapshot.children.allObjects as? [DataSnapshot] {
                for p in result{
                    self.likedPosts.append(p.key)
                }
            }
        })
    }
    func downloadPosts(){
//        downloadLikedPostsKeys()
        var l:[Post] = []
        self.ref.child("posts").observeSingleEvent(of: .value, with: {DataSnapshot in
            if let result = DataSnapshot.children.allObjects as? [DataSnapshot] {
//                result.map { }
                for p in result{
                    let list = p.value! as! NSDictionary
                    var P:Post=Post()
                    P.description=list["description"] as! String
                    P.title=list["title"] as! String
                    P.likes=list["likes"] as! Int
                    P.owner=list["owner"] as! String
                    P.upload_date=list["upload_date"] as! String
                    P.image=list["image"] as! String
//                    P.heart = "🖤"
                    l.append(P)
                    
                }
                    
            }
            self.posts=l
//            self.findEverywhere()
            self.downloadLikedPostsKeys()
            self.tableView.reloadData()
        })
        
    }
    func markup(){
        view.addBackground()
        [tableView,chooseIm,titlP].forEach { view.addSubview($0) }
        tableView.snp.makeConstraints() {
            $0.top.equalTo(titlP.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalToSuperview().offset(-245)
        }
        titlP.snp.makeConstraints() {
            $0.top.equalTo(view.snp.topMargin).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(48)
            $0.width.equalTo(300)
            
        }
        chooseIm.snp.makeConstraints() {
            $0.top.equalTo(view.snp.topMargin).offset(16)
            $0.left.equalTo(titlP.snp.right).offset(4)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
