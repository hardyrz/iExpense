import UIKit
import RealmSwift

class AccountsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var accountsTable : Results<AccountDTO>?
    var realm : Realm!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.realm = try! Realm()
        self.accountsTable = self.realm.objects(AccountDTO.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.accountsTable = realm.objects(AccountDTO.self)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.accountsTable?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath) as! AccountCell
        
        cell.accountLabel.text = self.accountsTable?[indexPath.row].name
        cell.accountImage.image = UIImage(named: "account_icon")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let filter = "name == '" + (self.accountsTable?[indexPath.row].name)! + "'"
            let accountToDelete = realm.objects(AccountDTO.self).filter(filter)
            
            try! realm.write {
                realm.delete(accountToDelete)
            }
            tableView.reloadData()
        }
    }

}

