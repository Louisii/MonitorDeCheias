//
//  Sheet.swift
//  MonitorDeCheias
//
//  Created by Turma02-3 on 19/04/24.
//

import SwiftUI

struct Sheet: View {
    
    @Binding var selectedLocation : Location
    
    var body: some View {
        ZStack{
            LinearGradient(stops: [
                Gradient.Stop(color: .white, location: 0),
                Gradient.Stop(color: Color("primarycolor"), location: 1)], startPoint: .top, endPoint: .bottom)
            VStack{
                Spacer()
                Image("aguinha")
                    .padding(.bottom, 50)
            }
            VStack{
                Text("\(selectedLocation.name)")
                    .font(.title).fontWeight(.bold)
                    .padding(.top, 20)
                Spacer()
            }
            VStack{
                Text("Nível da água: ")
                    .font(.title2.bold()).foregroundStyle(.white)
                    .padding(.top, 80)
                Text("30cm").font(.title2.bold()).foregroundStyle(.white)
                    .padding(.bottom, 25)
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(.white)
                    .imageScale(.large)
                Text("Alerta: ")
                    .font(.title2.bold()).foregroundStyle(.white)
                Text("Acima do normal!")
                    .font(.title2.bold()).foregroundStyle(.white)
                
            }

        }
    }
}
