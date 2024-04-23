//
//  GraficosView.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 17/04/24.
//

import SwiftUI
import Charts

struct GraficosView: View {
    
    @StateObject var leituraViewModel = LeituraSensorViewModel()
    let linearGradient = LinearGradient(gradient: Gradient(colors: [.red.opacity(0.4),.orange.opacity(0.4), .blue.opacity(0.4),.blue.opacity(0.2)]),startPoint: .top, endPoint: .bottom)
    
    
    var body: some View {
        
        VStack{
            
            
            GroupBox ( "Histórico de cheias") {
                if(leituraViewModel.leiturasHistorico.first != nil){
                    Text("\(leituraViewModel.leiturasHistorico.first?.bairro ?? "" ), \(leituraViewModel.leiturasHistorico.first?.cidade ?? "" ) - \(leituraViewModel.leiturasHistorico.first?.estado ?? "" )").padding(.vertical)
                }
                Chart{
                    ForEach(leituraViewModel.chartdata){ data in
                        
                        LineMark(x: .value("Data", data.date),
                                 y: .value("Nível", data.value)
                        )
                        
                    } 
                    .interpolationMethod(.catmullRom) .foregroundStyle(.red.opacity(0.4))
                        
                    
                    ForEach(leituraViewModel.chartdata){ data in
                        AreaMark(x: .value("Data", data.date),
                                 y: .value("Nível", data.value)
                        )}
                    .interpolationMethod(.catmullRom)
                               .foregroundStyle(linearGradient)
                    
                    
                }
//                .chartXAxis {
//                    AxisMarks(values: [0.0, 1.0, 2.0, 3.0], )
//                }
                
                .padding(.top)
                
            }.padding(.vertical).padding()
            
            
        }.onAppear(){
            leituraViewModel.fetchHistorio()
        }
        
    }
    
    
    
}


#Preview {
    GraficosView()
}
