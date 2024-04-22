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
    let data: Double
//    para converter timestamp para data: Text("\(NSDate(timeIntervalSince1970: leitura.data))")
    
   
}
