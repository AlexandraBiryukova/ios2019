//
//  File.swift
//  Sample
//
//  Created by Alexandra on 12/10/19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import Foundation
class Room {
    let name:String
    init(name:String){
        self.name = name
    }
}
class Address{
    var buildingName:String?
    var buildingNumber:String?
    var street: String?
    func buildingIdentifier() -> String?{
        if let buildingNumber = buildingNumber, let street = street{
            return "\(buildingNumber) \(street)"
        }else if buildingName != nil{
            return buildingName
        }else{
            return nil
        }
    }
}
class Residence {
    var rooms = [Room]()
    var numberOfRooms : Int{
        return rooms.count
    }
    subscript(i:Int) -> Room{
        get{
            return rooms[i]
        }
        set{
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms(){
        print("The number of rooms is \(numberOfRooms)")
    }
    var address:Address?
}

class Person{
    var residence: Residence?
}




