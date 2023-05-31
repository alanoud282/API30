//

import SwiftUI


struct Quote7: Codable {

let name: String
let username: String
let email: String
let phone: String
let website: String

}




struct A7: View {
    @State private var quotes = [Quote7]()
    
    var body: some View {
        NavigationView {
            
            List(quotes, id: \.name) { quote in
                
                VStack(alignment: .leading){
                    
                    
                    Text(quote.name)
                        .font(.headline)
                    Text(quote.username)
                    Text(quote.email)
                    Text(quote.website)
                    Text(quote.phone)
                    
                }
            }
            
            
            .navigationTitle("users ")
            .task{
                await fetchData()
            }
            
        }
    }
    
    func fetchData() async {
        let ApiUrl = "https://jsonplaceholder.typicode.com/users"
        
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
            
            let apiData = try JSONDecoder().decode([Quote7].self, from: data)
            quotes = apiData
            
        } catch {
            print("Error \(error)")
        }
    }
    
}

struct A7_Previews: PreviewProvider {
    static var previews: some View {
        A7()
    }
}
