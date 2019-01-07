import UIKit
import MapKit

class MapSearchViewController: UIViewController, MKMapViewDelegate
{
    @IBOutlet weak var mapType: UISegmentedControl!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var localSearch: UITextField!
    @IBOutlet weak var map: MKMapView!
    
    var selectedCity:String?
    var tempLong:Double?
    var tempLat:Double?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.latitude.isHidden = true
        self.longitude.isHidden = true
        
        let geoCoder = CLGeocoder();
        let addressString = selectedCity
        CLGeocoder().geocodeAddressString(addressString!, completionHandler:{(placemarks, error) in
            if error != nil
            {
                print("Geocode Failed: \(error!.localizedDescription)")
            }
            else if placemarks!.count > 0
            {
                let placemark = placemarks![0]
                let location = placemark.location
                let coords = location!.coordinate
                let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
                let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                self.map.setRegion(region, animated:true)
                let ani = MKPointAnnotation()
                ani.coordinate = placemark.location!.coordinate
                ani.title = placemark.locality
                ani.subtitle = placemark.subLocality
                self.tempLat = placemark.location?.coordinate.latitude
                self.tempLong = placemark.location?.coordinate.longitude
                self.map.addAnnotation(ani)
                self.latitude.text = (placemark.location?.coordinate.latitude)!.toString()
                self.longitude.text = (placemark.location?.coordinate.longitude)!.toString()
                self.latitude.isHidden = false
                self.longitude.isHidden = false
            }
        })
    }
    @IBAction func search(_ sender: Any)
    {
        if localSearch.text!.isEmpty
        {
            //Do Nothing
        }
        else
        {
            map.removeAnnotations(map.annotations)
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = self.localSearch.text
            let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
            request.region = self.map.region
            print(request.region)
            let search = MKLocalSearch(request: request)
            search.start{response, _ in
                guard let response = response else
                {
                    return
                }
                var matchingItems:[MKMapItem] = []
                matchingItems = response.mapItems
                if(matchingItems.isEmpty)
                {
                    //DO NOTHING
                }
                else
                {
                    for i in 0...matchingItems.count-1
                    {
                        //let place = matchingItems[i].placemark
                        let temp = MKPointAnnotation()
                        //temp.coordinate = place.location!.coordinate
                        temp.coordinate = matchingItems[i].placemark.location!.coordinate
                        //temp.title = place.name
                        temp.title = matchingItems[i].placemark.name
                        self.map.addAnnotation(temp)
                        let array = [matchingItems[i].placemark.locality!, matchingItems[i].placemark.name!]
                        print(array)
                    }
                }
            }
        }
    }
}

extension Double
{
    func toString() -> String
    {
        return String(format: "%.6f",self)
    }
}
