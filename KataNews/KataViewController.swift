
import UIKit

class KataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var kataDateLabel: UILabel!
    @IBOutlet weak var kataTable: UITableView!
    
//    var newsToday: News = News.todaysNews()
//    var newsItemsToday: [NewsItem]{
//        return newsToday.news
//    }
    
    var newsToday: DaysNews? = nil
    var newsItemsToday = [Item]()
        
//    Feed.getJson(){
//        (todaysNews:DaysNews) in
//            if let allNews = todaysNews as? DaysNews {
//                newsToday = todaysNews
//            }
//    
////            newsToday = todaysNews
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let newsDate = (2017, 2, 19)
//        navigationController?.hidesBarsOnSwipe = true
        
        //        adding a black background to the status bar
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = UIColor.black
        
        
        Feed.getDates(){
            (feedDates:FeedDates) in
//                print(feedDates.getComponents(date: feedDates.topDate))
                let showDateComponents = feedDates.getComponents(feedDates.topDate)
                let showDateStr = feedDates.getDateStr(feedDates.topDate)
            
                Feed.getJson(showDateComponents, dateStr: showDateStr.uppercased()){
                    (todaysNews:DaysNews) in
                        self.newsToday = todaysNews
                        self.newsItemsToday = todaysNews.allNews
                
                        //switch to the main thread and reload the data
                        OperationQueue.main.addOperation {
                            self.kataTable.reloadData()
                            self.kataDateLabel?.text = self.newsToday?.date
                        }
            }
            
        }
        
        
//        Feed.getJson(date: newsDate){
//            (todaysNews:DaysNews) in
//                self.newsToday = todaysNews
//                self.newsItemsToday = todaysNews.allNews
//            
////                self.kataDateLabel?.text = self.newsToday?.date
//            
//            //switch to the main thread and reload the data
//            OperationQueue.main.addOperation {
//                self.kataTable.reloadData()
//                self.kataDateLabel?.text = self.newsToday?.date
//            }
//
//        }

        kataTable.estimatedRowHeight = 80
        kataTable.rowHeight = UITableViewAutomaticDimension

//        kataDateLabel?.text = newsToday?.date ?? "some_val"
        
//        kataDateLabel?.text = newsToday.date
        
        kataTable.separatorStyle = UITableViewCellSeparatorStyle.none

        //code to test json reads
////        KataFeed.getJson()
////        let todaysNews:DaysNews = Feed.getJson()
//
//        Feed.getJson(){
//            (todaysNews:DaysNews) in
//            
//            print(todaysNews.date)
//            
//            for item in todaysNews.allNews{
//                
//                print(item.category)
//                print(item.title)
//                print(item.content)
//                print(item.url)
//                print("**************************")
//            }
//            
//        }
//        
////        print(todaysNews.date)
////        
////        for item in todaysNews.allNews{
////        
////            print(item.category)
////            print(item.title)
////            print(item.content)
////            print(item.url)
////            print("**************************")
////        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let myVal = newsItemsToday.count
        return myVal
//        return newsItemsToday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:CustomKataCell = tableView.dequeueReusableCell(withIdentifier: "customKataCell", for: indexPath) as! CustomKataCell
        
//        let newsItem = newsItemsToday?[indexPath.row] ?? Item("", "", "", "")

        let newsItem = newsItemsToday[indexPath.row]
        
        cell.customKataCategoryLabel?.text = newsItem.category
        cell.customKataHeadingLabel?.text = newsItem.title
        cell.customKataContentLabel?.text = newsItem.content
        
        //make cell unselectable
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        if (indexPath.row == 0){
            cell.customKataCellSeparator.backgroundColor = UIColor.white
        }else{
            cell.customKataCellSeparator.backgroundColor = UIColor(red:0.94, green:0.11, blue:0.11, alpha:1.0)
        }
        
        cell.customKataCategoryLabel.textColor = UIColor(red:0.94, green:0.11, blue:0.11, alpha:1.0)
        
        
        //setting content attributes such as line spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.71
        let text = cell.customKataContentLabel.attributedText
        let attrString = NSMutableAttributedString(attributedString: text!)
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        cell.customKataContentLabel.attributedText = attrString
        
        
        return cell
        
    }

}
