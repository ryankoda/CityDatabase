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
        
    }
}

extension Double
{
    func toString() -> String
    {
        return String(format: "%.6f",self)
    }
}
