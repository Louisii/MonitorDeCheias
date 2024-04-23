//
//  HomeView.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 17/04/24.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @StateObject var leituraViewModel = LeituraSensorViewModel()
    
    @State var position = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -27.6109852, longitude: -48.5489548),
        span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
    ))
    
    @State private var search: String = ""
    
//    @State private var selectedLocation: LeituraSensor = LeituraSensor(_id: "008da5e661fbb852b55c715d448f10dc", _rev: "d71c24c83b90f3db2e9219f944b3a717", deviceID: "testeHackaTruck", sensorAlerta: false, sensorAlaga: false, rua: "R. João Pereira dos Santos", bairro: "Ponte do Imaruim", cidade: "Palhoça", estado: "SC", data: "22/04/2024 16:35:02", latitude: -27.6355501, longitude: -48.6534832)
    var selectedLocation: LeituraSensor {
        return leituraViewModel.leituras.last!
    }
    
    
    @State private var showingSheet = false
    
    var searchResults: [LeituraSensor] {
        return leituraViewModel.leituras.filter{ $0.bairro.localizedCaseInsensitiveContains(search)}
        }
    @State var weatherColor: String = ""
    func checkAlert(){
        if selectedLocation.sensorAlerta == true{
            weatherColor = "chuvamoderada"
        } else if selectedLocation.sensorAlaga == true{
            weatherColor = "chuvamuitoforte"
        } else {
            weatherColor = "secondarycolor"
        }
    }

    var body: some View {
        ZStack{
            Map(position: $position){
                ForEach(leituraViewModel.leituras, id: \.self){ leitura in
                    Annotation(leitura.deviceID ,coordinate: CLLocationCoordinate2D(latitude: leitura.latitude, longitude: leitura.longitude)) {
                        ZStack {
                            Circle()
                                .fill(Color(weatherColor))
                                .frame(width: 28, height: 28)
                            Image(systemName: "mappin").foregroundColor(.white).onTapGesture{
                                print(leituraViewModel.leituras)
                                //selectedLocation = leitura
                                showingSheet = true
                            }
                        }.onAppear(){
                            checkAlert()
                        }
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                Sheet(selectedLocation: $leituraViewModel.leituras.last!)
            }
            .animation(.easeInOut(duration: 2)).ignoresSafeArea()
            
            VStack{
                Rectangle()
                    .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft, .bottomRight]))
                    .shadow(color: Color.black, radius: 10, y: -5)
                    .foregroundStyle(LinearGradient(stops: [
                        Gradient.Stop(color: .white, location: -0.6),
                        Gradient.Stop(color: Color("primarycolor"), location: 1),
                    ], startPoint: .top, endPoint: .bottom))
                        .frame(height: 100)
                        .overlay(
                            TextField("Procure uma região", text: $search, onCommit: {
                                if let foundLocation = searchResults.first {
                                    position = MapCameraPosition.region(
                                        MKCoordinateRegion(center: CLLocationCoordinate2D(
                                            latitude: foundLocation.latitude, longitude: foundLocation.longitude)
                                                           ,span:
                                                            MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)))
                                    }
                                })
                                .frame(height: 40)
                                .padding(.horizontal, 60)
                                .background(RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundStyle(Color.white)
                                    .padding(.horizontal, 50)))
                        .ignoresSafeArea()
                        Spacer()
            }
        }.onAppear(){
            leituraViewModel.fetchAllLeituras()
    }
    }
}

extension HomeView {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

#Preview {
    HomeView()
}
