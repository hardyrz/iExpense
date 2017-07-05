import UIKit
import RealmSwift

class NewCategoryViewController: UIViewController {
    
    @IBOutlet weak var nameImage: UIImageView!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var categoryInput: UIStackView!
    
    var realm : Realm!
    
    var imagesList : [String]!
    var imagePicker = UIPickerView()
    var selectedImage : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.realm = try! Realm()
        
        self.imagesList = ["food_icon", "gift_icon", "home_icon"]
        
        nameImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if (!(self.nameInput.text?.isEmpty)!) {
            let myCategory = CategoryDTO()
            myCategory.name = self.nameInput.text!
            try! realm.write {
                realm.add(myCategory)
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.imagesList.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imagesList[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedImage = imagesList[row]
        self.view.endEditing(false)
    }

}
