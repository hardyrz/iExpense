import UIKit

class ExpenseCell: UITableViewCell {
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var ValueLabel: UILabel!
    @IBOutlet weak var CategoryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
