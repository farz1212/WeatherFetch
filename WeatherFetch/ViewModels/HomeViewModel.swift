//
//  WeatherViewModel.swift
//  WeatherFetch
//
//  Created by Farzaad Goiporia on 2024-07-14.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var weather: ResponseBody?
    @Published var isLoading = false
    
    public let locationManager = LocationManager()
    public let weatherManager = WeatherManager()
    
    init() {
        fetchWeather()
    }
    
    func fetchWeather() {
        isLoading = true
        guard let location = locationManager.location else {
            isLoading = false
            return
        }
        
        Task {
            do {
                weather = try await weatherManager.getCurrentWeather(location.latitude, location.longitude, "ed5702fa584ad71c6016832392a92cc1")
                isLoading = false
            } catch {
                print("Error getting weather: \(error)")
                isLoading = false
            }
        }
    }
}
