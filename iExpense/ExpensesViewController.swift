import UIKit
import RealmSwift

class ExpensesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var expensesTable : Results<ExpenseDTO>?
    var realm : Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.realm = try! Realm()
        self.expensesTable = self.realm.objects(ExpenseDTO.self)
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
        //if let table = self.expensesTable {
        //    return table.count
        //}
        return (self.expensesTable?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseCell
        
        cell.DescriptionLabel.text = self.expensesTable?[indexPath.row].desc
        cell.ValueLabel.text = "USD " + String(Int((self.expensesTable?[indexPath.row].value)!))
        cell.CategoryImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image
        
        return cell
    }
}
