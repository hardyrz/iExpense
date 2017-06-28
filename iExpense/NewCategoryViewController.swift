import UIKit

class NewCategoryViewController: UIViewController {
    
    @IBOutlet weak var nameImage: UIImageView!
    @IBOutlet weak var nameInput: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        nameImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image
    }
    
    @IBAction func saveAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
