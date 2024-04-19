//
//  HomeView.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 17/04/24.
//

import SwiftUI
import MapKit

struct Location : Identifiable{
    let id = UUID()
    let name : String
    let coordinate: CLLocationCoordinate2D
}

struct HomeView: View {
    
    @State var position = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -27.6109852, longitude: -48.5489548),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    ))
    
    @State private var search: String = ""
    @State private var selectedLocation: Location =  Location(name: "Rio Tavares", coordinate: CLLocationCoordinate2D(latitude: -27.6836, longitude: -48.4861))
    @State private var showingSheet = false
    
    var locations = [
        Location(name: "Rio Tavares", coordinate: CLLocationCoordinate2D(latitude: -27.6836, longitude: -48.4861)),
        Location(name: "Centro", coordinate: CLLocationCoordinate2D(latitude: -27.597300, longitude: -48.549610 ))
    ]
    
    var searchResults: [Location] {
            return locations.filter { $0.name.localizedCaseInsensitiveContains(search) }
        }
//    func searchRegion(search: String) {
//        if(search ){
//
//        }
//    }
    
    var body: some View {
        ZStack{
            Map(position: $position){
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "mappin.and.ellipse")
                            .imageScale(.large)
                            .foregroundStyle(Color.red)
                            .onTapGesture {
                                selectedLocation = location
                                showingSheet = true
                               
                            }
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                Sheet(selectedLocation: $selectedLocation)
            }
            .animation(.easeInOut(duration: 2)).ignoresSafeArea()
            
            
            VStack{
                Rectangle()
//                    .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft, .bottomRight]))
                    .shadow(color: Color.black, radius: 10, y: -5)
                    .foregroundStyle(LinearGradient(stops: [
                        Gradient.Stop(color: .white, location: -0.6),
                        Gradient.Stop(color: Color("primarycolor"), location: 1),
                    ], startPoint: .top, endPoint: .bottom))
                        .frame(height: 100)
                        .overlay(
                            TextField("Procure uma região", text: $search, onCommit: {
                                if let foundLocation = searchResults.first {
                                    selectedLocation = foundLocation
                                    position = MapCameraPosition.region(
                                        MKCoordinateRegion(center: CLLocationCoordinate2D(
                                            latitude: foundLocation.coordinate.latitude, longitude: foundLocation.coordinate.longitude)
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
        }
    }
}

extension HomeView {
//    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
////        clipShape(RoundedCorner(radius: radius, corners: corners))
//    }
}

#Preview {
    HomeView()
}
