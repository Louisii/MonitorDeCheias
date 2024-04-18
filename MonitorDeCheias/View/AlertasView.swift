//
//  AlertasView.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 17/04/24.
//

import SwiftUI

struct AlertasView: View {
    @StateObject var viewModel = WeatherAPIViewModel()
    var lat : String = "-48.653707"
    var lon : String = "-27.636195"
    var body: some View {
        ZStack {
            Rectangle().fill( LinearGradient(gradient: Gradient(colors: [  .white, Color("primarycolor")]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea()
            VStack{
                Text("Alertas")
                Text(viewModel.weatherData?.weather.first?.description ?? "carregando..." )
                Text(String(viewModel.weatherData?.main?.temp ?? 0) )
            }.onAppear{
                viewModel.fetch(lat: lat, lon: lon)
            }
        }
    }
}

#Preview {
    AlertasView()
}
