//
//  LoactionManager.swift
//  WeatherFetch
//
//  Created by Farzaad Goiporia on 2024-06-17.
//

import Foundation
import CoreLocation

class LoactionManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    //Override init function to assign manager delegate
    override init(){
        super.init()
        manager.delegate = self
    }
    
    //Request location from user
    func requestLocation(){
        isLoading = true
        manager.requestLocation()
    }
    
    //Manage the location given by user
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
        
    }
    
    //Error handling
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
}

