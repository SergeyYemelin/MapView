//
//  ViewController.swift
//  MapView
//
//  Created by Сергей Емелин on 02.12.2024.
//

import UIKit
import MapKit


class MapViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate {
    
    var hotelCoordinates: CLLocationCoordinate2D?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    var userLocation = CLLocation()
    
    var hotel: Hotel!
    
    var staticMap = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
 
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
        if let coordinates = hotelCoordinates {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = hotel.name
            mapView.addAnnotation(annotation)
        } else {
            print("Hotel coordinates are nil")
        }
        let mapDragRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.didDragMap))

        mapDragRecognizer.delegate = self
        
        mapView.addGestureRecognizer(mapDragRecognizer)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        userLocation = location
        
        if let coordinates = hotelCoordinates {
            let hotelLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
            let distance = location.distance(from: hotelLocation)
            distanceLabel.text = String(format: "Distance: %.2f m", distance)
            
            let sourceLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let destinationLocation = hotelCoordinates!
            
            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
            let destinationPlacemark = MKPlacemark(coordinate: destinationLocation)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let directionRequest = MKDirections.Request()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .automobile
            
            let directions = MKDirections(request: directionRequest)
            
            directions.calculate { (response, error) in
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    return
                }
                
                let route = response.routes[0]
                
                self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)

                if self.staticMap {
                    let edgePadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: edgePadding, animated: true)
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        renderer.lineWidth = 2.0
        return renderer
    }
    
    @objc func didDragMap(gestureRecognizer: UIGestureRecognizer) {
        
        if (gestureRecognizer.state == UIGestureRecognizer.State.changed) {
            
            print("Map drag changed")
            staticMap = false
        }
    }
}

    
