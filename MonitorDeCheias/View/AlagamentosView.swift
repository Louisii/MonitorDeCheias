//
//  AlagamentosView.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 17/04/24.
//

import SwiftUI

struct AlagamentosView: View {
    @StateObject var leituraViewModel = LeituraSensorViewModel()
    
    
    var body: some View {
        NavigationView(){
                List{
                    ForEach(leituraViewModel.leituras.suffix(5).reversed(), id: \.self){ leitura in
                        HStack{
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color("chuvamuitoforte"))
                            
                            Text("\(leitura.bairro), \(leitura.cidade)")
                                .font(.title3)
                            
                            VStack{
                                Text(leitura.data)
                            }
                        }
                        .padding(.vertical, 10)
                        
                    }
                }
                .navigationTitle("Alagamentos")
                .onAppear(){
                    leituraViewModel.fetchAllLeituras()
                }
            }
        }
}

#Preview {
    AlagamentosView()
}
