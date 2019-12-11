//
//  Heart.swift
//  Arbook
//
//  Created by Alexandra on 12/3/19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import UIKit

class Heart: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right:  (bounds.width - 40))
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: (imageView?.frame.width)!-20)
        }
    }

}
