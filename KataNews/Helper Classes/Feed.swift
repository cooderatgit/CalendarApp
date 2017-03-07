//
//  Feed.swift
//  KataNews
//
//  Created by Pathum Mudannayake on 2/17/17.
//  Copyright © 2017 Pathum Mudannayake. All rights reserved.
//

import Foundation

struct Item{
    let title: String
    let category: String
    let content: String
    let url: String
    
    init?(json: [String: String]){
        guard let title = json["title"],
            let category = json["category"],
            let content = json["content"],
            let url = json["url"]
            else{
                return nil
        }
        
        self.title = title
        self.category = category
        self.content = content
        self.url = url
    }
    
//    init(_ title: String, _ category: String, _ content: String, _ url: String){
//        self.title = title
//        self.category = category
//        self.content = content
//        self.url = url
//    }
    
}


struct DaysNews{

    let date: String
    var allNews: [Item] = [Item] ()

    init?(json: [Dictionary<String, String>], date: String){

        self.date = date
        
        for dataItem in json{
            
////            let date: String = dataItem["date"] as! String
////            print(self.date)
//            
//            let wrappedTitle: [String:String] = dataItem["title"] as! [String:String]
////            print(wrappedTitle["rendered"]!)
//            
//            let wrappedContent: [String:Any] = dataItem["content"] as! [String:Any]
////            print(wrappedContent["rendered"]!)
//        
//            let newsItem = Item(wrappedTitle["rendered"]!, "Politics",  wrappedContent["rendered"]! as! String, "http://www.instancea.com/site/")

            let newsItem: Item = Item(json: dataItem)!
            
            allNews.append(newsItem)
        
        }
        
    }
    
}


struct FeedDates{
    var allDates: [Date] = [Date] ()
    let topDate: Date
    let dFormatter = DateFormatter()
    let calendar = Calendar.current
    
    init?(json: [String]){
        dFormatter.dateFormat = "yyyy-MM-dd"
        
        for dateStr in json{
            let date = dFormatter.date(from: dateStr)!
            allDates.append(date)
        }
        
        topDate = allDates.max()!
    }
    
    func getComponents(_ date: Date)->(year:Int,month:Int,day:Int){
        
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        return (year: year, month: month, day: day)
    }

    func getDateStr(_ date:Date)->String{
        dFormatter.dateFormat = "dd MMMM yyyy"
        return dFormatter.string(from: date)
    }
}


class Feed{
    
    class func getDates(_ completionHandler: @escaping (FeedDates) -> Void){
    
        let urlStr = "http://52.207.254.109/kata/index.php/wp-json/ianews/v1/dates"
        let url: URL = URL(string: urlStr)!
        var feedDates:FeedDates? = nil
        
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            if error != nil{
                print("Something went wrong")
                print(error!)
            }else{
                print("Got dates")
                do{
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String]
                    feedDates = FeedDates(json: parsedData)!
                    completionHandler(feedDates!)
                }catch{
                    print(error)
                }
            }
            
            }.resume()
    }
    
    

    class func getJson(_ date: (year: Int, month: Int, day: Int), dateStr: String, completionHandler: @escaping (DaysNews) -> Void){
        
        print("getJson is being called properly")
        
//                let urlStr = "https://jsonplaceholder.typicode.com/posts/1"
//        let urlStr = "http://52.207.254.109/kata/index.php/wp-json/wp/v2/posts?date=2017-02-09T00:00:00"
//        let urlStr = "http://52.207.254.109/kata/index.php/wp-json/ianews/v1/year/2017/month/2/date/19"
        let urlStr = "http://52.207.254.109/kata/index.php/wp-json/ianews/v1/year/\(date.year)/month/\(date.month)/date/\(date.day)"
        let url: URL = URL(string: urlStr)!
        
        var news:DaysNews? = nil
        
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            if error != nil{
                print("Something went wrong")
                print(error!)
            }else{
                print("Got data")
                do{
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [Dictionary<String, String>]
////                    print(parsedData[0]["content"]!)
//                    
//                    for dataItem in parsedData{
//                        let date: String = dataItem["date"] as! String
//                        print(date)
//                        
//                        let wrappedTitle: [String:String] = dataItem["title"] as! [String:String]
//                        print(wrappedTitle["rendered"]!)
//                        
//                        let wrappedContent: [String:Any] = dataItem["content"] as! [String:Any]
//                        print(wrappedContent["rendered"]!)
//                    }
//                    
////                    let firstNews: NewsUnit = NewsUnit(json: parsedData)!
////                    
////                    print(firstNews.id)
////                    print(firstNews.title)
////                    print(firstNews.content)

//                    news = DaysNews(json: parsedData, date: "31 FEBRUARY 2017")!
//                    news = DaysNews(json: parsedData, date: "31 JANUARY 2017")!
                    news = DaysNews(json: parsedData, date: dateStr)!
                    //return news! //this doesn't work should return a completionHandler
                    completionHandler(news!)
                    
                }catch{
                    print(error)
                }
            }
            
            }.resume()
      
//        completion(news!)
    }

}
