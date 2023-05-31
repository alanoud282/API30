//
//  A3.swift
//  API30
//
//  Created by ساره المرشد on 30/05/2023.
//

import SwiftUI

struct Quote2: Codable {
    
    var location_type : String
    var category: String
 
}


struct A3: View {
    @State private var quotes = [Quote2]()
    
    var body: some View {
        NavigationView {
            
            List(quotes, id: \.category) { quote in
                
                VStack(alignment: .leading){
                    Text(quote.category)
                        .font(.headline)
                   Text(quote.location_type)
                 
                }
            }
            
            .navigationTitle("")
            .task{
                await fetchData()
            }
            
        }
    }
    
    func fetchData() async{
        
        
        guard let url = URL(string: "https://data.police.uk/api/crimes-street/all-crime?lat=52.629729&lng=-1.131592&date=2023-01") else {
            
            print("hey man THIS URL DOES NOT WORK")
            
            return
        }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode([Quote2].self, from: data) {
                quotes  = decodedResponse
            }
        } catch {
            print("bod news... this data isn't valid ")
        }
    }
    
    
}




struct A3_Previews: PreviewProvider {
    static var previews: some View {
        A3()
    }
}
