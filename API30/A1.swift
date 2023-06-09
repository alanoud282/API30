//
//  A6.swift
//  API30
//
//  Created by ساره المرشد on 31/05/2023.
//

//
//  A1.swift
//  API30
//
//  Created by ساره المرشد on 30/05/2023.
//

import SwiftUI

struct Quote0: Codable {
    
    var occupation : String
    var name: String
    var gender: String
    var hairColor: String
    // var image: String
    
}

struct A1: View {
    @State private var quotes = [Quote0]()
    
    var body: some View {
        NavigationView {
            
            List(quotes, id: \.name) { quote in
                
                VStack(alignment: .leading){
                    
                    
                    Text(quote.name)
                        .font(.headline)
                    Text(quote.gender)
                    //Image(.logo)
                    Text(quote.hairColor)
                    Text(quote.occupation)
                    
                    
                }
            }
            
            
            .navigationTitle("Bob's burgers")
            .task{
                await fetchData()
            }
            
        }
    }
    
    func fetchData() async {
        let ApiUrl = "https://bobsburgers-api.herokuapp.com/characters/?limit=9&skip=305"
        
        guard let url = URL(string: ApiUrl) else {
            print("OH ... THE URL DOES NOT WORK")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                print("Can not get status code")
                return
            }
            
            if statusCode < 200 || statusCode > 299 {
                print("Status code: (statusCode), is not in 200s.")
                return
            }
            
            guard let dataAsString = String(data: data, encoding: .utf8) else {
                print("Can not convert data to string")
                return
            }
            
            print("Data as String: \(dataAsString)")
            
            let apiData = try JSONDecoder().decode([Quote0].self, from: data)
            quotes = apiData
            
        } catch {
            print("Error \(error)")
        }
    }
    
}
    
    struct A1_Previews: PreviewProvider {
        static var previews: some View {
            A1()
        }
    }

