import UIKit
import GoogleMaps
import CoreLocation

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
    
    @IBOutlet weak var userInputtedStartLocation: UITextField!
   
    @IBOutlet weak var userInputtedDestination: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
