//
//  AlertasView.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 17/04/24.
//

import SwiftUI

struct AlertasView: View {
    @StateObject var viewModel = WeatherAPIViewModel()
    var lon : String = "-48.653707"
    var lat : String = "-27.636195"
    
    
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-read-the-users-location-using-locationbutton
    //TODO ver como pegar a loc do usuario
    
    
    
    
    var body: some View {
        ZStack {
            Rectangle().fill( LinearGradient(gradient: Gradient(colors: [  .white, Color("primarycolor")]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea()
            VStack(alignment: .leading){
                HStack {
                    Spacer()
                    Text("Alertas de Chuva").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Image(systemName: "cloud.drizzle").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Spacer()
                    
                }.padding()
                
                
                //                Text("Tempo atual:")
                //                Text(viewModel.weatherData?.weather.first?.description ?? "carregando..." )
                //                Text(String(viewModel.weatherData?.main?.temp ?? 0) )
                //                Text("Volume de chuva nas últimas 3 horas: \(String(viewModel.forecastData?.list?.first?.rain?.threeH ?? 0))mm")
                //                Text(viewModel.forecastData?.list?.first?.dtTxt ?? "")
                
                
                if(viewModel.forecastData != nil){
                    
                    ScrollView {
                        VStack {
                            ForEach(viewModel.forecastData!.list!, id: \.self){item in
                                if let rain = item.rain?.threeH, rain > 0 {
                                    let bgColor: Color = {
                                        switch rain/3 {
//                                        case 0..<2.5: return Color("chuvaleve")
                                        case 2.5..<10: return Color("chuvamoderada")
                                        case 10..<50: return Color("chuvaforte")
                                        case 50...: return Color("chuvamuitoforte")
                                        default: return .white
                                        }
                                    }()
                                    
                                    
                                    HStack{
                                        Spacer()
                                        
                                        switch rain/3 {
                                        case 0..<2.5:
                                            Image(systemName: "cloud.sun.rain.fill").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                          
                                        case 2.5..<10:
                                            Image(systemName: "cloud.drizzle.fill").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                            
                                        case 10..<50:
                                            Image(systemName: "cloud.heavyrain.fill").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        default:
                                            Image(systemName: "cloud.bolt.rain.fill").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        }
                                       
                                        
                                        Spacer()
                                        VStack(alignment: .leading){
                                            
                                            switch rain/3 {
                                            case 0..<2.5:
                                                Text("Previsão de chuva fraca").font(.headline)
                                            case 2.5..<10:
                                                HStack {
                                                    Text("Previsão de chuva moderada").font(.headline)
                                                    Image(systemName: "exclamationmark.triangle.fill").foregroundStyle(.yellow)
                                                }
                                                
                                            case 10..<50:
                                                HStack {
                                                    Text("Previsão de chuva forte").font(.headline)
                                                    Image(systemName: "exclamationmark.triangle.fill").foregroundStyle(.orange)
                                                }
                                            default:
                                                HStack {
                                                    Text("Previsão de chuva muito forte (violenta)").font(.headline)
                                                    Image(systemName: "exclamationmark.triangle.fill").foregroundStyle(.red)
                                                }
                                               
                                            }
                                            
                                            Text("(\(String(item.rain!.threeH!))mm/3h)")
                                            
                                            if(item.dtTxt != nil){
                                                Text("\(formatDate(item.dtTxt!) ?? "")h")
                                            }
                                            
                                        }
                                        Spacer()
                                    }.padding(.vertical).background(
                                        LinearGradient(gradient: Gradient(colors: [ bgColor, .white]), startPoint: .leading, endPoint: .trailing)                                        ).cornerRadius(10).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).padding()
                                    
                                    
                                    
                                    
                                    
                                }
                            }
                        }
                    }
                }
                
                
                
                Spacer()
                
            }.onAppear{
                viewModel.fetchCurrentWeather(lat: lat, lon: lon)
                viewModel.fetchForecastWeather(lat: lat, lon: lon)
                
                
            }
        }
    }
    func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "EEEE, dd/MM 'às' HH"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }

}

#Preview {
    AlertasView()
}


