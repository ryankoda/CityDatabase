import Foundation
import CoreData
import UIKit
public class CityModel
{
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchResults = [City]()
    func fetchRecord()->Int
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"City")
        var x = 0
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [City])!
        x = fetchResults.count
        return x
    }
    func addCity(name:String, description:String)
    {
        
        // create a new entity object
        let ent = NSEntityDescription.entity(forEntityName: "City", in: self.managedObjectContext)
        //add to the manege object context
        let newItem = City(entity: ent!, insertInto: self.managedObjectContext)
        newItem.cityName = name
        newItem.cityDescription = description
        
        // save the updated context
        do {
            try self.managedObjectContext.save()
        } catch _ {
        }
    }
    func removeCity(row:Int)
    {
        managedObjectContext.delete(fetchResults[row])
        fetchResults.remove(at:row)
        do{
            try managedObjectContext.save()
        }catch{
        }
    }
    func getCityObject(row:Int)->City
    {
        return fetchResults[row]
    }
    func deleteAll()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"City")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest:fetchRequest)
        do
        {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
        } catch let _ as NSError{
        }
    }
}
