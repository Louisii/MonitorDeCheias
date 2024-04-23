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
    
    
    var body: some View {
        
        VStack{
            
            
            GroupBox ( "Histórico de cheias") {
                Text(leituraViewModel.leiturasHistorico.first?.bairro ?? "").padding(.vertical)
                Chart{
                    ForEach(leituraViewModel.chartdata){ data in
                        
                        
                        LineMark(x: .value("Data", data.date),
                                 y: .value("Nível", data.value)
                        )
                       
                        
                    }
                }.padding(.top)
                
            }.padding(.vertical).padding()
            
            
        }.onAppear(){
            leituraViewModel.fetchHistorio()
        }
        
    }
    
    
    
}


#Preview {
    GraficosView()
}
