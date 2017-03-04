

import Foundation

class News{
    
    var date: String
    var titleOfTheDay: String //a title briefing the day's stories
    var news: [NewsItem] //all news stories of a day
    
    init(date: String, title: String, news: [NewsItem]){
        self.date = date
        self.titleOfTheDay = title
        self.news = news
    
    }
    
    class func todaysNews() -> News
    {
        var todaysNewsItems = [NewsItem]()

        todaysNewsItems.append(NewsItem(category: "1. POLITICS", title: "Neil Goruch for Supreme Court Justice", content: "Neil Gorsuch is President Trump’s pick to replace late Supreme Court Justice Antonin Scalia. Gorsuch is 49 years old, relatively young for a Justice. He graduated from Columbia, Harvard and Oxford and believes in originalism, which means interpreting the words of the Constitution the way they were meant when they were written.", url: "s_1_url", imageLocation: "apple-watch.png"))

        todaysNewsItems.append(NewsItem(category: "2. ENTERTAINMENT", title: "Ben Affleck Steps Down", content: "Neil Gorsuch is President Trump’s pick to replace late Supreme Court Justice Antonin Scalia. Gorsuch is 49 years old, relatively young for a Justice. He graduated from Columbia, Harvard and Oxford and believes in originalism, which means interpreting the words of the Constitution the way they were meant when they were written.", url: "s_1_url", imageLocation: "apple-watch.png"))
        
 
       todaysNewsItems.append(NewsItem(category: "3. TECH", title: "Facebook Stories", content: "Neil Gorsuch is President Trump’s pick to replace late Supreme Court Justice Antonin Scalia. Gorsuch is 49 years old, relatively young for a Justice. He graduated from Columbia, Harvard and Oxford and believes in originalism, which means interpreting the words of the Constitution the way they were meant when they were written.", url: "s_1_url", imageLocation: "apple-watch.png"))
        
        
        return News(date: "31 JANUARY 2017", title: "Immigrants, Bolt and Facebook Stories", news: todaysNewsItems)
    }


}
