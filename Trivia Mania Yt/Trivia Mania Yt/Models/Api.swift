//
//  Api.swift
//  Trivia Mania Yt
//
//  Created by Imran Sefat on 11/4/22.
//

import SwiftUI

class Api {
    // make the function to get the data from the API
    // let's use a completion to easily handle the data
    func getData(completion: @escaping ([DataModel]) -> ()) {
        guard let url = URL(string: "https://jservice.io/api/random") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            let dataModel = try! JSONDecoder().decode([DataModel].self, from: data!)
            DispatchQueue.main.async {
                completion(dataModel)
            }
        }
        .resume()
        
    }
}
