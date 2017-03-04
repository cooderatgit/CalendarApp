

import UIKit

class CustomBodyCell: UITableViewCell {

    @IBOutlet weak var customNewsCategoryLabel: UILabel!
    
    @IBOutlet weak var customNewsHeadingLabel: UILabel!
    
    @IBOutlet weak var customNewsContentLabel: UILabel!
    
    @IBOutlet weak var customCellSeparator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
