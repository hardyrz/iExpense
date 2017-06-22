import UIKit

class ExpensesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var expensesTable : [ExpenseDTO]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if let table = self.expensesTable {
        //    return table.count
        //}
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseCell
        
        cell.DescriptionLabel.text = "Dinner" //expensesTable[indexPath.row].description
        cell.ValueLabel.text = "USD" + String(15) //expensesTable[indexPath.row].value
        cell.CategoryImage.image = UIImage(named: "food_icon") //expensesTable[indexPath.row].category.image
        
        return cell
    }
}
