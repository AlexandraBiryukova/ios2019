//
//  CachePost.swift
//  Arbook
//
//  Created by Alexandra on 12/3/19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import Foundation
import CoreData


public class CachePost: NSManagedObject {
    @NSManaged var desc: String
    @NSManaged var likes: Int64
    @NSManaged var image: String
    @NSManaged var title: String
    @NSManaged var upload_date: String
    @NSManaged var owner: String
}

