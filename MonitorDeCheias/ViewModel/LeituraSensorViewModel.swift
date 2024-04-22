//
//  LeituraSensorViewModel.swift
//  MonitorDeCheias
//
//  Created by Louisi Dalazen on 22/04/24.
//

import Foundation


class LeituraSensorViewModel : ObservableObject {
    @Published var leituras : [LeituraSensor] = []
    
    func fetchAllLeituras(){
        guard let url = URL(string:
        "http://127.0.0.1:1880/leitura/hacka/teste"
        
        ) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
              
                let parsed = try JSONDecoder().decode([LeituraSensor].self, from: data)
                    DispatchQueue.main.async {
                        self?.leituras = parsed
                    }
                
            }catch{
                print(error)
            }
        }
        
        task.resume()
    }
    
    
   
    
}
