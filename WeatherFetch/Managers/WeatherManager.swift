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
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
