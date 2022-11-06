//
//  HomeViewController.swift
//  GPS_speed
//
//  Created by Julien Guillan on 02/08/2021.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    var speed: CLLocationSpeed = CLLocationSpeed()
    var locationManager: CLLocationManager = CLLocationManager()
    var trip: [CLLocation] = []
    var distance: Double = 0
    
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var unitLabel: UILabel!
    @IBOutlet var meanSpeedLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if self.locationManager.authorizationStatus == CLAuthorizationStatus.authorizedAlways {
            self.locationManagerDidChangeAuthorization(self.locationManager)
        } else {
            self.speedLabel.sizeToFit()
            self.speedLabel.text = "Not authorized"
        }
    }

    @IBAction func onClickReset(_ sender: Any) {
        self.distance = 0;
        self.trip = []
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var tripText = ""
        self.trip.append(locations[0])
        if(self.trip.count >= 2) {
            let lastDistance = self.trip.last?.distance(from: self.trip[self.trip.count - 2])
            self.distance += lastDistance ?? 0
        }
        self.speed = self.locationManager.location?.speed ?? 0
        self.speed = self.speed * 3.6
        self.speedLabel.text = (String(format: "%.1f", self.speed))
        if self.distance / 1000 >= 1 {
            tripText = (String(format: "%.2f km", self.distance / 1000))
        } else {
            tripText = (String(format: "%.1f m", self.distance))
        }
        self.distanceLabel.text = tripText
    }
    
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status != CLAuthorizationStatus.denied{
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == CLAuthorizationStatus.authorizedAlways {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
}
