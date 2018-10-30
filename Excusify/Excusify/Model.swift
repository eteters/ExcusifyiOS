//
//  Model.swift
//  Excusify
//
//  Created by Evan Teters on 10/29/18.
//  Copyright © 2018 Evan Teters. All rights reserved.
//

import Foundation

class Model {
    static var sharedInstance = Model()

    var currentResponse: NYTStatusResponse?

    let apiKey = "bc6c041204f8452284d308e4be07fa06"

    let urlBase = "https://api.nytimes.com/svc/search/v2/articlesearch.json"
    
    var allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted)

    
    func NYTSearchApiCall(dispatchQueueForHandler:DispatchQueue, searchTerm:String, completionHandler: @escaping (String?) -> Void){

        guard let escapedSearchText = searchTerm.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) else {
            dispatchQueueForHandler.async(execute: {
                completionHandler("Problem preparing search text")
            })
            return
        }
        
        let urlString = urlBase + "?api-key=" + apiKey + "&q=" + escapedSearchText
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        guard let url = URL(string: urlString) else{
            dispatchQueueForHandler.async {
                completionHandler("Request Url is bad")
            }
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        let task = session.dataTask(with: urlRequest) { (data, responseCode, error) in
            guard error == nil, let data = data else {
                var errorString = "urlRequest did not work"
                if let error = error {
                    errorString = error.localizedDescription
                }
                dispatchQueueForHandler.async(execute: {
                    completionHandler(errorString)
                })
                return
            }
            
            let responseObject = try? JSONDecoder().decode(NYTStatusResponse.self, from: data)
            self.currentResponse = responseObject
            
            dispatchQueueForHandler.async(execute: {
                completionHandler(nil)
            })
            
        }
        task.resume()
    }
}
