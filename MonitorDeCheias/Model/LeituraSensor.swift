//
//  LeituraSensor.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 22/04/24.
//

import Foundation

struct LeituraSensor: Codable, Hashable {
  
    let _id: String
    let _rev: String
    let deviceID: String
    let sensorAlerta: Bool
    let sensorAlaga: Bool
    let rua: String
    let bairro: String
    let cidade: String
    let estado: String
    let latitude: Double
    let longitude: Double
    let data: String
    
    
}
