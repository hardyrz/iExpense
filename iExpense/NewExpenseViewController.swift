import UIKit
import RealmSwift

class NewExpenseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var valueImage: UIImageView!
    @IBOutlet weak var descriptionImage: UIImageView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var dateImage: UIImageView!
    
    
    @IBOutlet weak var valueInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    @IBOutlet weak var categoryInput: UITextField!
    @IBOutlet weak var accountInput: UITextField!
    @IBOutlet weak var dateInput: UITextField!
    
    
    var realm : Realm!
    var categoriesList : Results<CategoryDTO>!
    var categoryPicker = UIPickerView()
    var selectedCategory : CategoryDTO?
    
    var accountsList : Results<AccountDTO>!
    var accountPicker = UIPickerView()
    var selectedAccount : AccountDTO?
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.realm = try! Realm()
        self.categoriesList = realm.objects(CategoryDTO.self)
        self.accountsList = realm.objects(AccountDTO.self)
        
        self.valueImage.image = UIImage(named: "value_icon")
        self.descriptionImage.image = UIImage(named: "description_icon")
        self.categoryImage.image = UIImage(named: "category_icon")
        self.accountImage.image = UIImage(named: "account_icon")
        self.dateImage.image = UIImage(named: "date_icon")

        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        self.categoryInput.inputView = categoryPicker
        
        accountPicker.dataSource = self
        accountPicker.delegate = self
        self.accountInput.inputView = accountPicker
        
        setCurrentDate()
        createDatePicker()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if (Int(self.valueInput.text!) != nil && self.selectedCategory != nil) {
            let myExpense = ExpenseDTO()
            myExpense.value = Int(self.valueInput.text!)!
            myExpense.desc = self.descriptionInput.text!
            myExpense.category = self.selectedCategory
            myExpense.account = self.selectedAccount
            myExpense.date = self.datePicker.date
            
            try! realm.write {
                realm.add(myExpense)
            }
        
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == self.categoryPicker) {
            return self.categoriesList.count
        } else {
            return self.accountsList.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == self.categoryPicker) {
            return categoriesList.elements[row].name
        } else {
            return accountsList.elements[row].name
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == self.categoryPicker) {
            self.categoryInput.text = categoriesList.elements[row].name
            self.selectedCategory = categoriesList.elements[row]
        } else {
            self.accountInput.text = accountsList.elements[row].name
            self.selectedAccount = accountsList.elements[row]
        }
        self.view.endEditing(false)
    }
    
    func createDatePicker() {
        
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton] , animated: false)
        
        self.dateInput.inputAccessoryView = toolbar
        self.dateInput.inputView = self.datePicker
    }
    
    func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        self.dateInput.text = dateFormatter.string(from: self.datePicker.date)
        self.view.endEditing(true)
    }
    
    func setCurrentDate() {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        self.dateInput.text = formatter.string(from: date)
    }
}
