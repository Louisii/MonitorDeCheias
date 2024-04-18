//
//  HomeView.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 17/04/24.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @State var position = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -27.6109852, longitude: -48.5489548),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    ))
    
    var body: some View {
        Map(position: $position){}.animation(.easeInOut(duration: 2)).ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
