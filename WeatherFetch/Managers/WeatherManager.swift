//
//  WeatherManager.swift
//  WeatherFetch
//
//  Created by Farzaad Goiporia on 2024-06-17.
//

import Foundation
import CoreLocation

class WeatherManager{
    func getCurrentWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees, _ APIKey: String) async throws -> ResponseBody{
        
        //Create URL from Open Weather API
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(APIKey)&units=metric") else {fatalError("Incorrect URL")}
        
        //Create URLRequest
        let urlRequest = URLRequest(url: url)
        
        //Store response and data from the URLRequest
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        //Check status code of response
        guard(response as? HTTPURLResponse)?.statusCode == 200 else{fatalError("Error Fetching Weather Data")}
        
        //Decode data into Model ResponseBody
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}
