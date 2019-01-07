import Foundation
import CoreData


extension City
{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City>
    {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var cityDescription: String?
    @NSManaged public var cityImage: NSData?
    @NSManaged public var cityName: String?

}
