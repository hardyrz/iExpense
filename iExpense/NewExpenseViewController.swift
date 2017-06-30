import UIKit
import RealmSwift

class NewExpenseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var valueImage: UIImageView!
    @IBOutlet weak var descriptionImage: UIImageView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var accountImage: UIImageView!
    
    @IBOutlet weak var valueInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    @IBOutlet weak var categoryInput: UITextField!
    @IBOutlet weak var accountInput: UITextField!
    
    var realm : Realm!
    var categoriesList : Results<CategoryDTO>!
    var categoryPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.realm = try! Realm()
        self.categoriesList = realm.objects(CategoryDTO.self)
        
        self.valueImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image
        
        self.descriptionImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image
        
        self.categoryImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image
        
        self.accountImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image

        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        self.categoryInput.inputView = categoryPicker
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
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.categoriesList.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoriesList.elements[row].name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.categoryInput.text = categoriesList.elements[row].name
        self.view.endEditing(false)
    }
}
