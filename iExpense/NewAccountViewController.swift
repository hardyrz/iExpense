import UIKit
import RealmSwift

class NewAccountViewController: UIViewController {
    
    @IBOutlet weak var nameImage: UIImageView!
    @IBOutlet weak var nameInput: UITextField!
    
    var realm : Realm!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.realm = try! Realm()
        
        nameImage.image = UIImage(named: "account_icon")
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        if (!(self.nameInput.text?.isEmpty)!) {
            let myAccount = AccountDTO()
            myAccount.name = self.nameInput.text!
            try! realm.write {
                realm.add(myAccount)
            }
            
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}
