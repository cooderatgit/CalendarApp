
import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("calendar view controller loaded")
        
        calendarView.dataSource = self
        calendarView.delegate = self
        print("just after delegate")
        calendarView.registerCellViewXib(file: "CalendarCell") // Registering your cell is manditory
        calendarView.cellInset = CGPoint(x: 0, y: 0)

//        myLabel.text = "Calendar"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2016 02 01")! // You can use date generated from a formatter
        let endDate = Date()                                // You can also use dates created from this function
        let calendar = Calendar.current                     // Make sure you set this up to your time zone. We'll just use default here
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6,
                                                 calendar: calendar,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: .sunday)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let myCustomCell = cell as! CalendarCellView
        
        // Setup Cell text
        myCustomCell.dayLabel.text = cellState.text
        
        // Setup text color
        if cellState.dateBelongsTo == .thisMonth {
            myCustomCell.dayLabel.textColor = UIColor(colorWithHexValue: 0xECEAED)
        } else {
            myCustomCell.dayLabel.textColor = UIColor(colorWithHexValue: 0x574865)
        }
    }
}

extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}



