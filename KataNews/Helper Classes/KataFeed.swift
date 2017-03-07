//
//  KataFeed.swift
//  KataNews
//
//  Created by Pathum Mudannayake on 2/9/17.
//  Copyright © 2017 Pathum Mudannayake. All rights reserved.
//

import Foundation

struct NewsUnit{
    let id: Int
    let title: String
    let content: String
    
    init?(json: [String: Any]){
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let content = json["body"] as? String
        else{
            return nil
        }
        
        self.id = id
        self.title = title
        self.content = content
    }
}


class KataFeed{

    class func getJson(){
    
        print("getJson is being called properly")
        
//        let urlStr = "https://jsonplaceholder.typicode.com/posts/1"
        let urlStr = "http://52.207.254.109/kata/index.php/wp-json/wp/v2/posts?date=2017-02-09T00:00:00"
        let url: URL = URL(string: urlStr)!
//        let urlRequest: URLRequest = URLRequest(url: url)
        
        
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
                if error != nil{
                    print("S thing went wrong")
                    print(error!)
                }else{
                    print("Got data")
//                    print(data!)
                    do{
                        let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
//                        print(parsedData["userId"] ?? 0)
//                        print(parsedData["body"] ?? "None")
                        
                        let firstNews: NewsUnit = NewsUnit(json: parsedData)!
                        
                        print(firstNews.id)
                        print(firstNews.title)
                        print(firstNews.content)
                        
                    }catch{
                        print(error)
                    }
                }
        
        }.resume()
        
        
    }


}
