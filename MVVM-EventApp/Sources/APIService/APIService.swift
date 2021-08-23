//
//  APIService.swift
//  MVVM-EventApp
//
//  Created by Gabriel on 18/08/21.
//

import Foundation

struct APIService {
    
    private let apiURL = URL(string: "https://5f5a8f24d44d640016169133.mockapi.io/api/events/")!
  
    func fetchAllData(comp : @escaping ([EventModel]?) -> ()) {
        URLSession.shared.dataTask(with: apiURL) {
            (data, URLResponse, error) in
            if error == nil {
                do {
                    let result = try JSONDecoder().decode([EventModel].self, from: data!)
                    DispatchQueue.main.async {
                        comp(result)
                        print(result)
                    }
                } catch {
                    print("JSON Error")
                }
            }
        }.resume()
    }
}
