//
//  ContentView.swift
//  WeatherFetch
//
//  Created by Farzaad Goiporia on 2024-06-17.
//

import SwiftUI

struct Home: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationManager.location{
                if let weather = weather{
                    WeatherView(weather: weather)
                } else{
                    LoadingView()
                        .task {
                            do{
                                weather = try await weatherManager.getCurrentWeather(location.latitude, location.longitude, "ed5702fa584ad71c6016832392a92cc1")
                            } catch{
                                print("Error getting weather:\(error)")
                            }
                        }
                }
            } else{
                if locationManager.isLoading{
                    LoadingView()
                } else{
                    WelcomeView().environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.763, saturation: 0.936, brightness: 0.375))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    Home()
}
