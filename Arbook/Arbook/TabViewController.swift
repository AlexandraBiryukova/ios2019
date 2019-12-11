//
//  TabViewController.swift
//  Arbook
//
//  Created by Alexandra on 12/1/19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let f = HomeViewController()
        f.title="Home"
        f.tabBarItem.image=UIImage(named: "home")
        f.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        f.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 8.0)
        let s = MyPostsViewController()
        s.title="My posts"
        s.tabBarItem.image=UIImage(named: "my")
        s.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        s.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 8.0)
        let t = LikedPostsViewController()
        t.title="Favorites"
        t.tabBarItem.image=UIImage(named: "heart")
        t.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        t.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 8.0)
        let p = ProfileViewController()
        p.title="Profile"
        p.tabBarItem.image=UIImage(named: "profile")
        p.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        p.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 8.0)
        let l = [f,s,t,p]
        viewControllers = l.map { UINavigationController(rootViewController: $0) }
        UITabBar.appearance().tintColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        UITabBar.appearance().barTintColor=#colorLiteral(red: 0.08217292746, green: 0.08217292746, blue: 0.08217292746, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }

}
