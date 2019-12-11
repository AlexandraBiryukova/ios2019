//
//  MyPostsViewController.swift
//  Arbook
//
//  Created by Alexandra on 12/1/19.
//  Copyright © 2019 Alexandra. All rights reserved.
//


// Send to Roma

import UIKit
import Firebase
import FirebaseUI

class LikedPostsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var ref: DatabaseReference!
    var n = UINavigationController()
    let storage = Storage.storage()
    var storageRef:StorageReference! = nil
    var posts:[Post] = []
    var likedPosts: [String] = []
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 200
        view.tableFooterView = UIView(frame: .zero)
        view.backgroundColor=UIColor.clear
        view.estimatedRowHeight = 300
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        view.register(PostTableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 21)!]
        self.navigationController?.navigationBar.barTintColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        
        self.storageRef = self.storage.reference()
        tableView.delegate = self
        tableView.dataSource = self
        ref=Database.database().reference()
        downloadPosts()
        markup()
    }
    
   
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        cell.titl.text=self.posts[indexPath.section].title
        cell.desc.text=self.posts[indexPath.section].description
        cell.date.text=self.posts[indexPath.section].upload_date
        let imageUrlString = self.posts[indexPath.section].image
        let reference = self.storageRef.child(imageUrlString)
//        print(reference)
        cell.imageOf.sd_setImage(with:  reference)
        return cell
    }
    
    
    func downloadPosts(){
        var l:[Post] = []
        let phone = Auth.auth().currentUser?.phoneNumber
        self.ref.child("users").child((Auth.auth().currentUser?.phoneNumber)!).child("posts").observeSingleEvent(of: .value, with: {DataSnapshot in
            if let result = DataSnapshot.children.allObjects as? [DataSnapshot] {
                for p in result{
                    self.likedPosts.append(p.key)
                    let list = p.value! as! NSDictionary
                    var P:Post=Post()
                    P.description=list["description"] as! String
                    P.title=list["title"] as! String
                    P.likes=list["likes"] as! Int
                    P.owner=list["owner"] as! String
                    P.upload_date=list["upload_date"] as! String
                    P.image=list["image"] as! String
                    l.append(P)
                }
            }
            self.posts=l
            self.tableView.reloadData()
        })
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
    
    func markup(){
        view.addBackground()
        [tableView].forEach { view.addSubview($0) }
        tableView.snp.makeConstraints() {
            $0.top.equalTo(view.snp.topMargin).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalToSuperview().offset(-185)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        downloadPosts()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor=UIColor.clear
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.posts.count
    }
}
