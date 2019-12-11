//
//  ChooseImageViewController.swift
//  Arbook
//
//  Created by Alexandra on 12/1/19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseUI

class ChooseImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var vSpinner: UIView?
    var setOfNames: [String] = []
    var sample: String = ""
    var storage = Storage.storage()
    
    var storageRef:StorageReference! = nil
    var callBack: ((_ image: UIImage, _ address : String)-> Void)?
    
    lazy var set:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor=UIColor.clear
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Choose image"
        self.storageRef = storage.reference()
        self.set.register(ImCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 21)!]
        self.navigationController?.navigationBar.barTintColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        self.navigationController?.navigationBar.tintColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(set)
       
        view.addBackground()
        
        
        
        set.snp.makeConstraints(){
            $0.top.equalTo(view.snp.topMargin).offset(16)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalToSuperview().offset(-160)
        }
        
        set.delegate = self
        set.dataSource = self
        self.set.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImCollectionViewCell
//        print(self.storageRef)
        let reference = self.storageRef.child("im/\(indexPath.row).jpg")
//        print(reference)
        cell.imageOf.sd_setImage(with:  reference)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let cell = collectionView.cellForItem(at: indexPath) as!  ImCollectionViewCell
        
        
        var ima = cell.imageOf.image
        var vc = NewPostViewController()
        callBack!(ima!, "im/\(indexPath.row).jpg")
        self.navigationController?.popViewController(animated: true)
        
    }
        
}

