import UIKit
import RealmSwift

class NewExpenseViewController: UIViewController {
    
    @IBOutlet weak var valueImage: UIImageView!
    @IBOutlet weak var descriptionImage: UIImageView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var accountImage: UIImageView!
    
    @IBOutlet weak var valueInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    @IBOutlet weak var categoryInput: UITextField!
    @IBOutlet weak var accountInput: UITextField!
    
    var realm : Realm!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.realm = try! Realm()
        
        self.valueImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image
        
        self.descriptionImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image
        
        self.categoryImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image
        
        self.accountImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image

        
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if (Int(self.valueInput.text!) != nil) {
            let myExpense = ExpenseDTO()
            myExpense.value = Int(self.valueInput.text!)!
            myExpense.desc = self.descriptionInput.text!
            try! realm.write {
                realm.add(myExpense)
            }
        
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
