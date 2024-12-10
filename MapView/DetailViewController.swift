//
//  DetailViewController.swift
//  MapView
//
//  Created by Сергей Емелин on 03.12.2024.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var mapViewMini: MKMapView!
    
    @IBAction func goToMap(_ sender: Any) {
        performSegue(withIdentifier: "showMap", sender: self)
    }
    var hotel: Hotel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: hotel.image)
        nameLabel.text = hotel.name
        adressLabel.text = hotel.adress
        
        let annotation = MKPointAnnotation()

        annotation.coordinate = CLLocationCoordinate2D(latitude: hotel.latitude, longitude: hotel.longitude)
        annotation.title = hotel.name
        mapViewMini.addAnnotation(annotation)
        let showRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapViewMini.setRegion(showRegion, animated: true)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            if let mapVC = segue.destination as? MapViewController {
              
                mapVC.hotelCoordinates = CLLocationCoordinate2D(latitude: hotel.latitude, longitude: hotel.longitude)
                mapVC.hotel = hotel
            }
        }
    }
}
