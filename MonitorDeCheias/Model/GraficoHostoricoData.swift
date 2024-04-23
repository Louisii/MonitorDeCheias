//
//  GraficoHostoricoData.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 22/04/24.
//

import Foundation
import Charts

struct LineChartData : Identifiable {
    
    var id = UUID()
    var date: Date
    var value: Double
    
}
