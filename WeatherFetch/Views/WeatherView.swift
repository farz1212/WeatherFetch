//
//  WeatherView.swift
//  WeatherFetch
//
//  Created by Farzaad Goiporia on 2024-06-17.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    var body: some View {
        VStack(alignment: .leading){
            VStack{
                VStack(alignment: .leading, spacing: 5){
                    Text(weather.name)
                        .bold().font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack{
                    HStack{
                        VStack(spacing: 10){
                            if(weather.weather[0].main == "Clouds"){
                                Image(systemName: "cloud")
                                    .font(.system(size: 40))
                            }else if(weather.weather[0].main == "Rain"){
                                Image(systemName: "cloud.rain")
                                    .font(.system(size: 40))
                            }else if(weather.weather[0].main == "Smoke"){
                                Image(systemName: "smoke")
                                    .font(.system(size: 40))
                            }
                            else{
                                Image(systemName: "sun.max")
                                    .font(.system(size: 40))
                            }
                            Text(weather.weather[0].main)
                        }
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                    }
                    .frame(height: 80)
                    .padding(20)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2018/12/10/16/22/city-3867295_1280.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(x: 0,y: 100)
                    } placeholder: {
                        ProgressView()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack{
                Spacer()
                VStack(alignment: .leading, spacing: 20){
                    Text("Weather Now")
                        .bold()
                        .padding()
                    
                    HStack{
                        WeatherRow(logo: "thermometer", name: "Min temp", value: weather.main.tempMin.roundDouble() + "°")
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max temp", value: weather.main.tempMax.roundDouble() + "°")
                    }
                    HStack{
                        WeatherRow(logo: "wind", name: "Wind Speed", value: weather.wind.speed.roundDouble() + "m/s")
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: weather.main.humidity.roundDouble() + "%")
                    }
                    .padding(.bottom)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .foregroundColor(Color(hue: 0.763, saturation: 0.936, brightness: 0.375))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.763, saturation: 0.936, brightness: 0.375))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    WeatherView(weather: previewWeather)
}
