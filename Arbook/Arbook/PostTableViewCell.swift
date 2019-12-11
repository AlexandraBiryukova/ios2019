//
//  PostTableViewCell.swift
//  Arbook
//
//  Created by Alexandra on 11/21/19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import UIKit
import SnapKit

class PostTableViewCell: UITableViewCell {
    
    
    lazy var titl: UILabel = {
        let button = UILabel()
        button.font=UIFont(name: "Avenir Next", size: 25)
        button.textColor=#colorLiteral(red: 0.5490196078, green: 0.2745098039, blue: 0.8901960784, alpha: 1)
        button.numberOfLines = 2
        return button
    }()
    lazy var desc: UILabel = {
       let button = UILabel()
       button.font=UIFont(name: "Avenir Next", size: 15)
       button.textColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
       button.numberOfLines=3
       return button
    }()
    lazy var date: UILabel = {
       let button = UILabel()
       button.font=UIFont(name: "Avenir Next", size: 15)
       button.textColor=#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
       return button
   }()
    lazy var imageOf:UIImageView = {
        let imageV = UIImageView()
        imageV.layer.cornerRadius = 8
        imageV.clipsToBounds = true
        imageV.contentMode = .scaleAspectFill
//        imageV.layer.borderColor=UIColor.black.cgColor
//        imageV.layer.borderWidth=2
        return imageV
    }()
    lazy var arrow:UIImageView = {
        let imageV = UIImageView()
        imageV.clipsToBounds = true
        imageV.contentMode = .scaleAspectFill
        imageV.image = UIImage(named:"right")
    //        imageV.layer.borderColor=UIColor.black.cgColor
    //        imageV.layer.borderWidth=2
            return imageV
        }()
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.layer.backgroundColor=#colorLiteral(red: 0.2145842202, green: 0.2096153286, blue: 0.2964094883, alpha: 0.9390404929)
        self.contentView.layer.cornerRadius = 16
        self.contentView.addSubview(titl)
        self.contentView.addSubview(desc)
        self.contentView.addSubview(date)
        self.contentView.addSubview(imageOf)
        self.contentView.addSubview(arrow)
        
        titl.snp.makeConstraints() {
            $0.top.equalTo(contentView).offset(16)
            $0.left.equalTo(imageOf.snp.right).offset(8)
            $0.width.equalTo(170)
        }
        desc.snp.makeConstraints() {
            $0.top.equalTo(date.snp.bottom).offset(8)
            $0.left.equalTo(imageOf.snp.right).offset(8)
            $0.width.equalTo(150)
            
        }
        imageOf.snp.makeConstraints() {
            $0.top.equalTo(contentView).offset(10)
            $0.bottom.equalTo(contentView).offset(-10)
            $0.left.equalTo(contentView).offset(10)
            $0.width.equalTo(170)
        }
        date.snp.makeConstraints() {
            $0.top.equalTo(titl.snp.bottom).offset(4)
            $0.left.equalTo(imageOf.snp.right).offset(8)
            $0.width.equalTo(100)
        }
        arrow.snp.makeConstraints() {
            $0.top.equalTo(contentView.center.x).offset(84)
            $0.right.equalTo(contentView).offset(-8)
            $0.width.equalTo(32)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}
