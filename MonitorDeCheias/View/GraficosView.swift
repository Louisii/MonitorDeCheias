//
//  GraficosView.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 17/04/24.
//

import SwiftUI

struct GraficosView: View {
    @StateObject var leituraViewModel = LeituraSensorViewModel()
    var body: some View {
        ScrollView  {
            VStack{
                ForEach(leituraViewModel.leituras, id: \.self){ leitura in
                    
                    VStack(alignment: .leading){
                        Text(leitura.deviceID)
                        Text("sensor alerta: \(leitura.sensorAlerta)")
                        Text("sensor alaga: \(leitura.sensorAlaga)")
                        Text(leitura.deviceID)
                        Text("\(NSDate(timeIntervalSince1970: leitura.data))")
                    }.padding().background()
                    
                }
            }.onAppear(){
                leituraViewModel.fetchAllLeituras()
        }
        }
    }
}

#Preview {
    GraficosView()
}
