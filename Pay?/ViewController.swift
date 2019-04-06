//
//  ViewController.swift
//  Pay?
//
//  Created by Tyler P Admin on 4/4/19.
//  Copyright © 2019 Tyler P Admin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    // MARK: - Properties
    let menuLauncher = MenuLauncher()
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mapView.delegate = self
        checkLocationServices()
        view.addSubview(mapView)
        view.addSubview(menuButton)
    }
    @IBAction func MenuShow(_ sender: Any) {
        menuLauncher.showMenu()
    }
        
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorizationStatus()
        } else {
            //Show alert for letting the user know they to turn on LocationServices
        }
    }
    
    
    // MARK: - CLLocationManager
    func checkLocationAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            //Show alert how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            
            break
        @unknown default:
            print("error")
        }
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    

    
}

// MARK: - MKMapViewDelegate
extension ViewController: MKMapViewDelegate {
    
//    func mapView(_ mapView: MKMapView, didUpdate
//        userLocation: MKUserLocation) {
//        mapView.centerCoordinate = userLocation.location!.coordinate
//    }
}

extension ViewController: CLLocationManagerDelegate {
    
    //This delegate is buggy af and doesn't let you pan on mapView
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        checkLocationAuthorizationStatus()
    }
    
}
