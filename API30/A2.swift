//
//  A2.swift
//  API30
//
//  Created by ساره المرشد on 30/05/2023.
//



import SwiftUI

struct Quote1: Codable {
    
   var type : String
    var name: String
    var path: String
    //var hairColor: String
   // var image: String
    
}

    struct A2: View {
        @State private var quotes = [Quote1]()
        
        var body: some View {
            NavigationView {
                
                List(quotes, id: \.name) { quote in
                    
                    VStack(alignment: .leading){
                        
                        
                        Text(quote.name)
                            .font(.headline)
                        Text(quote.type)
//                        //Image(.logo)
                        Text(quote.path)
//                        Text(quote.occupation)
                        
                                
                            }
                    }
                    
                    
                    .navigationTitle("Final Space")
                    .task{
                        await fetchData()
                    }
                    
                }
            }
            
            func fetchData() async{
                
                
                guard let url = URL(string: "https://finalspaceapi.com/api/v0/") else {
                    
                    print("hey man THIS URL DOES NOT WORK")
                    
                    return
                }
                
                do {
                    
                    let (data, _) = try await URLSession.shared.data(from: url)
                    
                    if let decodedResponse = try? JSONDecoder().decode([Quote1].self, from: data) {
                        quotes  = decodedResponse
                    }
                } catch {
                    print("bod news... this data isn't valid ")
                }
            }
            
            
        }
        
        
        
  
struct A2_Previews: PreviewProvider {
    static var previews: some View {
        A2()
    }
}
