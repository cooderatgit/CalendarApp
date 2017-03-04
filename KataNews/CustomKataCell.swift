

import UIKit

class CustomKataCell: UITableViewCell {

    @IBOutlet weak var customKataCategoryLabel: UILabel!
    @IBOutlet weak var customKataHeadingLabel: UILabel!
    @IBOutlet weak var customKataContentLabel: UILabel!
    @IBOutlet weak var customKataCellSeparator: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //print("this gets called")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
