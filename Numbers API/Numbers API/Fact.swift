//
//  Fact.swift
//  Numbers API
//
//  Created by Alexandra on 30.09.19.
//  Copyright © 2019 Alexandra. All rights reserved.
//

import Foundation
import Alamofire

class Fact{
    var value=""
    var number=""
    
    init(value: String,number:String) {
        self.value = value
        self.number = number
    }
    
    static func downloadFact(for type: String,for number:String, completion: @escaping (Fact) -> Void) {
         var url = URL(string: "https://numbersapi.p.rapidapi.com/\(number)/\(type)")!
        if(type.contains("random")){
            url = URL(string: "https://numbersapi.p.rapidapi.com/\(number)/trivia")!
        }
        
       
        
        let parameters: Parameters = [
            "number": number,
            "fragment": "true",
            "json": "true"
        ]
        
        let headers: HTTPHeaders = [
            "X-RapidAPI-Host" : "numbersapi.p.rapidapi.com",
            "X-RapidAPI-Key" : "2d17a8fd06msh0f3a07563d45c23p106988jsn8218a60dc2ea",
            "accept" : "application/json"
        ]
        
        Alamofire.request(url, method: .get,parameters:parameters, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let json):
                print(response.value)
                let value = (json as! [String : Any])["text"] as! String
                let val = (json as! [String : Any])["number"]
                print(val)
                let fact = Fact(value: value,number: "\(val)")
                print(fact)
                completion(fact)
            }
        })
    }
}
