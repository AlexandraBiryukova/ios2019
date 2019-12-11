//
//  ImageCollectionViewCell.swift
//  Arbook
//
//  Created by Alexandra on 12/2/19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import UIKit

class ImCollectionViewCell: UICollectionViewCell {
    lazy var imageOf:UIImageView = {
        let imageV = UIImageView()
        imageV.layer.cornerRadius = 10
        imageV.contentMode = .scaleAspectFit
        imageV.clipsToBounds = true
        imageV.layer.borderColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        imageV.layer.borderWidth=2
        imageV.frame = CGRect(x: 0, y: 0, width: 360, height:200)
        return imageV
        
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageOf)
        imageOf.snp.makeConstraints() {
            $0.top.equalTo(contentView)
            $0.right.equalTo(contentView)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
