import Foundation
import CoreData

public class Person: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var age: Int64
}

public class Place: NSManagedObject {
    @NSManaged var longitude: Double
    @NSManaged var latitude: Double
    @NSManaged var comment:String
}
