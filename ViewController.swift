import UIKit
import JTAppleCalendar

class ViewController: UITableViewController {

    @IBAction func calendarPopUp(_ sender: UIBarButtonItem) {
        
        print("popup button tapped")
        
        if let overlayView = (Bundle.main.loadNibNamed("CalendarViewController", owner: self, options: nil)?.first as? JTAppleCalendarView) {
            self.navigationController?.view.addSubview(overlayView)
        }
                
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
           
}

