//
//  A5.swift
//  API30
//
//  Created by ساره المرشد on 31/05/2023.
//

import SwiftUI

struct Quote4: Codable {
    
    var title : String
    var internalName: String
   var dealID: String
    //var hairColor: String
    // var image: String
    
}


struct A5: View {
    @State private var quotes = [Quote4]()
    
    var body: some View {
        NavigationView {
            
            List(quotes, id: \.title) { quote in
                
                VStack(alignment: .leading){
                    
                   
                    Text(quote.title)
                        
                   Text(quote.internalName)
                        .font(.headline)
                    Text(quote.dealID)
                    //
                }
            }
            
            
            .navigationTitle("CheapShark")
            .task{
                await fetchData()
            }
            
        }
    }
    
    func fetchData() async{
        
        
        guard let url = URL(string: "https://www.cheapshark.com/api/1.0/deals?upperPrice=15") else {
            
            print("hey man THIS URL DOES NOT WORK")
            
            return
        }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode([Quote4].self, from: data) {
                quotes = decodedResponse
            }
        } catch {
            print("bod news... this data isn't valid ")
        }
    }
    
    
}




struct A5_Previews: PreviewProvider {
    static var previews: some View {
        A5()
    }
}
