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
    var parcours: [CLLocation] = []
    var distance: Double = 0
    
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    
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

    @IBAction func onClickReset(_ sender: Any) {
        self.distance = 0;
        self.parcours = []
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.parcours.append(locations[0])
        if(self.parcours.count >= 2) {
            let lastDistance = self.parcours.last?.distance(from: self.parcours[self.parcours.count - 2])
            self.distance += lastDistance ?? 0
        }
        self.speed = self.locationManager.location?.speed ?? 0
        self.speed = self.speed * 3.6
        print(self.speed)
        self.speedLabel.text = (String(format: "%.1f Km/h", self.speed))
        self.distanceLabel.text = (String(format: "%.1f m", self.distance))
    }
    
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status != CLAuthorizationStatus.denied{
            locationManager.startUpdatingLocation()
        }
    }
}
