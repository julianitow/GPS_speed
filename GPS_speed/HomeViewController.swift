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
    
    @IBOutlet var speedLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.speed = self.locationManager.location?.speed ?? 0
        self.speed = self.speed * 3.6
        print(self.speed)
        self.speedLabel.text = (String(format: "%.1f Km/h", self.speed))
    }
    
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status != CLAuthorizationStatus.denied{
            locationManager.startUpdatingLocation()
        }
    }
}
