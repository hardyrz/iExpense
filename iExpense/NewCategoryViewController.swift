import UIKit
import RealmSwift

class NewCategoryViewController: UIViewController {
    
    @IBOutlet weak var nameImage: UIImageView!
    @IBOutlet weak var nameInput: UITextField!
    
    var realm : Realm!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.realm = try! Realm()
        
        nameImage.image = UIImage(named: "category_icon")
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if (!(self.nameInput.text?.isEmpty)!) {
            let myCategory = CategoryDTO()
            myCategory.name = self.nameInput.text!
            try! realm.write {
                realm.add(myCategory)
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
