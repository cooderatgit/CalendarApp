
import UIKit
import JTAppleCalendar

class ViewController: UITableViewController {
    
    @IBOutlet weak var dateLabel: UILabel!

    var newsToday: DaysNews? = nil
    var newsItemsToday = [Item]()
    
//    var newsToday: News = News.todaysNews()
//    var newsItemsToday: [NewsItem]{
//        return newsToday.news
//    }
    @IBAction func calendarPopUp(_ sender: UIBarButtonItem) {
        
        print("popup button tapped")
//        self.navigationController?.navigationBar.layer.zPosition = -1
//        let popupView = Bundle.main.loadNibNamed("OverlayViewController", owner: self.navigationController, options: nil)?.first as! OverlayViewController
//        self.navigationController?.view.addSubview(popupView)
        
//        let myVC = CalendarViewController(nibName: "CalendarViewController", bundle: nil)
        
        
        if let overlayView = (Bundle.main.loadNibNamed("Calendar", owner: self.navigationController, options: nil)?.first as? CalendarViewController) {
//            overlayView.myLabel.text = "Calendar"
//            self.navigationController?.view.addSubview(overlayView)
//            overlayView.view.backgroundColor = UIColor.brown
            self.navigationController?.view.addSubview(overlayView.view)
        }
        

//        if let overlayView = (Bundle.main.loadNibNamed("Test", owner: self.navigationController, options: nil)?.first as? TestViewController) {
//            //            overlayView.myLabel.text = "Calendar"
//            //            self.navigationController?.view.addSubview(overlayView)
////            self.navigationController?.view.addSubview(overlayView)
////            overlayView.testLabel.text = "My Label"
//            self.navigationController?.view.addSubview(overlayView.myView)
////            self.navigationController?.viewControllers.append(overlayView)
//            
//        }
        

//        self.navigationController!.pushViewController(OverlayView(nibName: "CalendarViewController", bundle: nil), animated: true )

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        
        //navigationController?.hidesBarsOnSwipe = true
        //navigationController?.navigationBar.barTintColor = UIColor.green
        
        
//        adding a black background to the status bar
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = UIColor.black
        
        //self.navigationItem.title = "31 Jan 2017"
        
        //swipe gesture recognizers
        let swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(self.respondToSwipeGesture))
        swipeRight.direction = .right

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = .left
        
        
        self.tableView.addGestureRecognizer(swipeRight)
        self.tableView.addGestureRecognizer(swipeLeft)
        

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
                    self.tableView.reloadData()
                    //self.reloadData()
                    self.dateLabel?.text = self.newsToday?.date
                }
            }
            
        }
        
        
//        let titleLabel = UILabel()
//        titleLabel.text = "31 Jan 2017"
//        titleLabel.textColor = UIColor.white
//        titleLabel.backgroundColor = UIColor.white
//        navigationItem.titleView = titleLabel
        
//        let imageView = UIImageView(image: UIImage(named: "Menu-52"))
//        imageView.contentMode = UIViewContentMode.scaleAspectFit
//        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
//        imageView.frame = titleView.bounds
//        titleView.addSubview(imageView)
        
//        let titleLabel = UILabel()
//        titleLabel.textColor = UIColor.white
//        titleLabel.text = "31 Jan 2017"
//        
//        titleLabel.contentMode = UIViewContentMode.scaleAspectFit
//        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
//        titleLabel.frame = titleView.bounds
//        titleView.addSubview(titleLabel)
//        
//        self.navigationItem.titleView = titleView
//        
//        dateLabel.text = newsToday.date
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
//        tableView.tableHeaderView?.backgroundColor = UIColor.blue
      
        //let tableHeader:CustomHeaderView = tableView.tableHeaderView as! CustomHeaderView
        //tableHeader.customDateLabel?.text = newsToday.date
        
//        tableView.separatorColor = UIColor.blue
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
//        tableView.bounces = false
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //        return products.count
        return newsItemsToday.count
    }
    
    
    //indexPath is a struct with a row number
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /**
         the following code tries to reuse a cell from the set of cells that is constructed for a table; deque one from the tableview, populate it with data and display.
         for optimization purposes, ios uses only a set of cells and reuses them as a user scrolls through the table. For example, if there were 1000 items to display in a table, constructing 1000 different cells would have been a waste, therefore, only a few cells are created and they are used over and over again populating them with new data as a user scrolls through. some tables uses more than one type of cell, therefore, a string identifier is used to denote each type of cell.
         **/
        
        
        let cell:CustomBodyCell = tableView.dequeueReusableCell(withIdentifier: "kataCell", for: indexPath) as! CustomBodyCell
        
        let newsItem = newsItemsToday[indexPath.row]
        
        cell.customNewsCategoryLabel?.text = newsItem.category
        cell.customNewsHeadingLabel?.text = newsItem.title
        cell.customNewsContentLabel?.text = newsItem.content
        
        //make cell unselectable
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        //setting table's seperator to none will get rid of horizontal seperators altogether
        //cell.separatorInset = UIEdgeInsetsMake(50, 50, 50, 50)
        
        //cell.customCellSeparator.backgroundColor = UIColor.gray
        
        if (indexPath.row == 0){
                        cell.customCellSeparator.backgroundColor = UIColor.white
        }else{
            cell.customCellSeparator.backgroundColor = UIColor(red:0.94, green:0.11, blue:0.11, alpha:1.0)
        }
        
        cell.customNewsCategoryLabel.textColor = UIColor(red:0.94, green:0.11, blue:0.11, alpha:1.0)
        
        //maybe set the width of the cell separator to the width of the content label; or make labels
        //and the separators fixed width
        
        
        //setting content attributes such as line spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.71
        let text = cell.customNewsContentLabel.attributedText
        let attrString = NSMutableAttributedString(attributedString: text!)
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        cell.customNewsContentLabel.attributedText = attrString
        
        
        return cell
        
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "kataHeaderCell")
//        return cell
//    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "My Name"
//    }
    
    
    //event on gesture
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            default:
                break
            }
        }
    }
    
}

