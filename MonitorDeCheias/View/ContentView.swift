//
//  ContentView.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 17/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
           
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            AlagamentosView()
                .tabItem {
                    Label("Alagamentos", systemImage: "water.waves")
                }
            AlertasView()
                .tabItem {
                    Label("Alertas", systemImage: "cloud.bolt.rain.fill")
                }
            GraficosView()
                .tabItem {
                    Label("Gráficos", systemImage: "chart.xyaxis.line")
                }
           
        }
    }
    
}

#Preview {
    ContentView()
}
