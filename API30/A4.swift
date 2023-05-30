//
//  A4.swift
//  API30
//
//  Created by ساره المرشد on 31/05/2023.
//
import SwiftUI

struct Quote3: Codable {

   //var type : String
    var auction_name: String
    var auction_slug: String
   //var winning_bid_max: Double
   // var image: String
}

    struct A4: View {
        @State private var quotes = [Quote3]()
        
        var body: some View {
            NavigationView {
                
                List(quotes, id: \.auction_name) { quote in
                    
                    VStack(alignment: .leading){
                        
                        
                        Text(quote.auction_name)
                            .font(.headline)
                        Text(quote.auction_slug)
                            .font(.headline)
//                        Text(quote.winning_bid_max)
//                            .font(.headline)
//
                            }
                    }
                    
                    
                    .navigationTitle("")
                    .task{
                        await fetchData()
                    }
                    
                }
            }
            
            func fetchData() async{
                
                
                guard let url = URL(string: "https://whiskyhunter.net/api/auctions_data/?format=json") else {
                    
                    print("hey man THIS URL DOES NOT WORK")
                    
                    return
                }
                
                do {
                    
                    let (data, _) = try await URLSession.shared.data(from: url)
                    
                    if let decodedResponse = try? JSONDecoder().decode([Quote3].self, from: data) {
                        quotes  = decodedResponse
                    }
                } catch {
                    print("bod news... this data isn't valid ")
                }
            }
            
            
        }
        
        
struct A4_Previews: PreviewProvider {
    static var previews: some View {
        A4()
    }
}
