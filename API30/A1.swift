//
//  A1.swift
//  API30
//
//  Created by ساره المرشد on 30/05/2023.
//

import SwiftUI

struct Quote5: Codable {
    
    var occupation : String
    var name: String
    var gender: String
    var hairColor: String
   // var image: String
    
}

    struct A1: View {
        @State private var quotes = [Quote5]()
        
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
            
            func fetchData() async{
                
                
                guard let url = URL(string: "https://bobsburgers-api.herokuapp.com/characters/?limit=9&skip=305") else {
                    
                    print("hey man THIS URL DOES NOT WORK")
                    
                    return
                }
                
                do {
                    
                    let (data, _) = try await URLSession.shared.data(from: url)
                    
                    if let decodedResponse = try? JSONDecoder().decode([Quote5].self, from: data) {
                        quotes  = decodedResponse
                    }
                } catch {
                    print("bod news... this data isn't valid ")
                }
            }
            
            
        }
        
        
        
        struct A1_Previews: PreviewProvider {
            static var previews: some View {
                A1()
            }
        }
