import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces

class Directions {
    var startLocation = "startLocation" {
        didSet {
            print(startLocation)
        }
    }
    var destination = "destination" {
        didSet {
            print(destination)
        }
    }
    var startLoc: CLLocationCoordinate2D?
}


class WelcomeViewController: UIViewController {
    
    let directions = Directions()
    
    var locationToSet: UITextField?
    
    @IBOutlet weak var userInputtedStartLocation: UITextField!
   
    @IBOutlet weak var userInputtedDestination: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fillAddressForm(address: String){
            directions.startLocation = address
            locationToSet?.text = address
    }
    
    
    @IBAction func autocompleteClicked(_ sender: UITextField) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        locationToSet = sender;
        print("LOCATION TO SET")
        print(locationToSet ?? "locationToSet is nil")
        
        // Set a filter to return only addresses.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func autocompleteClickedDest(_ sender: UITextField) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        locationToSet = sender;
        print("LOCATION TO SET")
        print(locationToSet ?? "locationToSet is nil")
        
        // Set a filter to return only addresses.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        present(autocompleteController, animated: true, completion: nil)
    }
    
    
    @IBAction func getDirectionsButton(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let directions = Directions()
        directions.startLocation = userInputtedStartLocation.text!
        directions.destination = userInputtedDestination.text!
        if let viewController2 = segue.destination as? DirectionsViewController {
            viewController2.directions = directions
        }
    }
    
    
}

extension WelcomeViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Print place info to the console.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress ?? "Address string is nil")")
        
        // Call custom function to populate the address form.
        fillAddressForm(address: place.formattedAddress!)
        
        // Close the autocomplete widget.
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Show the network activity indicator.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // Hide the network activity indicator.
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
