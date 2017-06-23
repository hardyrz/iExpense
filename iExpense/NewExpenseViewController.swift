import UIKit

class NewExpenseViewController: UIViewController {
    
    @IBOutlet weak var valueImage: UIImageView!
    @IBOutlet weak var descriptionImage: UIImageView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var accountImage: UIImageView!
    
    @IBOutlet weak var valueInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    @IBOutlet weak var categoryInput: UITextField!
    @IBOutlet weak var accountInput: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        valueImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image
        
        descriptionImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image
        
        categoryImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image
        
        accountImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image

        
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
