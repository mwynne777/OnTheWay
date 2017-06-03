import UIKit
import GoogleMaps
import CoreLocation

class DirectionsViewController: UIViewController {
    
    var mapView: GMSMapView?
    var camera: GMSCameraPosition?
    
    var directions: Directions?
    
    var coordinates:CLLocationCoordinate2D?
    
    let address = "Statue of Liberty"
    
    var isWorking: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(directions?.startLocation ?? "I think this means the data didn't send properly")
        print("We have reached the DirectionsViewController")
        
        check(url: "https://www.google.com/", address: (directions?.startLocation)!) { (isWorking) in
            if isWorking {
                print("True")
                print(self.coordinates ?? "Coordinates are nil")
                self.displayMapOfLocationsFromWelcomeView(location: "I don't even know")
            } else {
                print("False")
            }
        }
        
        //let geocoder = CLGeocoder()
        
        /*geocoder.geocodeAddressString(address, completionHandler: { [weak weakSelf = self] (placemarks, error) -> Void in
         if((error) != nil){
         print("Error", error ?? "Sorry, not working")
         }
         if let placemark = placemarks?.first {
         weakSelf?.coordinates = placemark.location!.coordinate
         //print(placemark.location!.coordinate)
         //weakSelf?.displayMapOfLocationsFromWelcomeView(location: address)
         print("End of closure")
         }
         })*/
    }
    
    func check(url : String, address : String, completion: @escaping (_ isWorking: Bool)->()) {
        let url = NSURL(string: url)
        print("Checking")
        let task = URLSession.shared.dataTask(with: url! as URL) {(data, response, error) in
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address, completionHandler: { [weak weakSelf = self] (placemarks, error) -> Void in
                if((error) != nil){
                    print("Error", error ?? "Sorry, not working")
                }
                if let placemark = placemarks?.first {
                    weakSelf?.coordinates = placemark.location!.coordinate
                    //print(placemark.location!.coordinate)
                    //weakSelf?.displayMapOfLocationsFromWelcomeView(location: address)
                    print("End of closure")
                    completion(true)
                }
            })
        }
        task.resume()
    }
    
    func displayMapOfLocationsFromWelcomeView(location: String) {
        
        print(coordinates ?? "I think this means the coordinates are nil?")
        self.camera = GMSCameraPosition.camera(withLatitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!, zoom: 12)
        //let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 100, height: 100))
        self.mapView = GMSMapView.map(withFrame: .zero, camera: camera!)
        self.view = self.mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!)
        marker.title = location
        marker.snippet = location
        //print((coordinates?.latitude)!)
        //print((coordinates?.longitude)!)
        marker.map = mapView
    }
    
    
}
