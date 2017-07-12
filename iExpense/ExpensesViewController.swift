import UIKit
import RealmSwift

class ExpensesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var expensesTable : Results<ExpenseDTO>?
    var realm : Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let config = Realm.Configuration(schemaVersion: try! schemaVersionAtURL(Realm.Configuration.defaultConfiguration.fileURL!) + 1)
        Realm.Configuration.defaultConfiguration = config
        self.realm = try! Realm()
        self.expensesTable = self.realm.objects(ExpenseDTO.self)
        
        self.navigationController?.tabBarItem.image = UIImage(named: "value_icon")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.expensesTable = realm.objects(ExpenseDTO.self)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.expensesTable?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseCell
        
        cell.DescriptionLabel.text = self.expensesTable?[indexPath.row].desc
        cell.ValueLabel.text = "USD " + String(Int((self.expensesTable?[indexPath.row].value)!))
        let cat = self.expensesTable?[indexPath.row].category?.name
        let letter = cat?.index((cat?.startIndex)!, offsetBy: 1)
        
        cell.categoryLabel.text = cat?.substring(to: letter!)
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 0.4)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let filter = "desc == '" + (self.expensesTable?[indexPath.row].desc)! + "'"
            let expenseToDelete = realm.objects(ExpenseDTO.self).filter(filter)
            
            try! realm.write {
                realm.delete(expenseToDelete)
            }
            tableView.reloadData()
        }
    }
}
