
import Foundation
import UIKit

class NewsItem{

    var category: String
    var title: String
    var content: String
    var url: String
//    var image: UIImage
    
    init(category: String, title: String, content: String, url: String, imageLocation: String){
    
        self.category = category
        self.title = title
        self.content = content
        self.url = url
        
//        //In the following case the syntax is:
//        //img = UIIMage(named: imageLocation),
//        //then if img is not null, image = img else, set to a default value
//        if let img = UIImage(named: imageLocation) {
//            self.image = img
//        } else {
//            self.image = UIImage(named: "default")!
//        }
        
    
    }
    
}
