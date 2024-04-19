//
//  WeatherAPIViewModel.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 17/04/24.
//

import Foundation


class WeatherAPIViewModel : ObservableObject {
    @Published var weatherData : WeatherData?
    @Published var forecastData : ForecastData?
    
    func fetchCurrentWeather(lat : String, lon : String){
        guard let url = URL(string:
        "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=2907aecb2f1f20ee92acfd18da61ee56&units=metric&lang=pt_br"
        
        ) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
              
                let parsed = try JSONDecoder().decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        self?.weatherData = parsed
                    }
                
            }catch{
                print(error)
            }
        }
        
        task.resume()
    }
    
    func fetchForecastWeather(lat : String, lon : String){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=2907aecb2f1f20ee92acfd18da61ee56&units=metric&lang=pt_br" ) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
              
                let parsed = try JSONDecoder().decode(ForecastData.self, from: data)
                    DispatchQueue.main.async {
                        self?.forecastData = parsed
                        print(parsed)
                        print(String(self?.forecastData?.list?.first?.rain?.threeH ?? 0) )
                    }
                
            }catch{
                print(error)
            }
        }
        
        task.resume()
    }
    
   
    
}
