//
//  LeituraSensorViewModel.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 22/04/24.
//

import Foundation


class LeituraSensorViewModel : ObservableObject {
    @Published var leituras : [LeituraSensor] = []
    @Published var leiturasHistorico : [LeituraSensor] = []
    @Published var chartdata : [LineChartData] = []
    
    func fetchAllLeituras(){
        guard let url = URL(string:
        "http://192.168.128.244:1880/leitura/hacka/teste"
        
        ) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
              
                let parsed = try JSONDecoder().decode([LeituraSensor].self, from: data)
                    DispatchQueue.main.async {
                        self?.leituras = parsed.sorted { $0.data < $1.data }
                    }
                
            }catch{
                print(error)
            }
        }
        
        task.resume()
    }
    func fetchHistorio(){
        guard let url = URL(string:
        "http://192.168.128.244:1880/leitura/hacka/teste/historico"
        
        ) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
              
                let parsed = try JSONDecoder().decode([LeituraSensor].self, from: data)
                    DispatchQueue.main.async {
                        self?.leiturasHistorico = parsed
                        self?.convertToChartData(sensors: parsed)
                    }
                
            }catch{
                print(error)
            }
        }
        
        task.resume()
    }
    
    func convertToChartData(sensors: [LeituraSensor]) {
        let sortedSensors = sensors.sorted { $0.data < $1.data }
        var chartData: [LineChartData] = []
        for sensor in sortedSensors {
            let value: Double
            if sensor.sensorAlaga {
                value = 3.0
            } else if sensor.sensorAlerta {
                value = 2.0
            } else {
                value = 1.0
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "pt_BR") // Setting the locale to Brazilian Portuguese

            let data: Date = dateFormatter.date(from: sensor.data) ?? Date().addingTimeInterval(86400)
            let dataPoint = LineChartData(date: data, value: value)
            chartData.append(dataPoint)
        }
        chartdata = chartData
        print(chartData)
    }

   
    
}
