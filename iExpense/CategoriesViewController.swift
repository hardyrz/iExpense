import UIKit
import RealmSwift

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var categoriesTable : Results<CategoryDTO>?
    var realm : Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.realm = try! Realm()
        self.categoriesTable = self.realm.objects(CategoryDTO.self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.categoriesTable = realm.objects(CategoryDTO.self)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if let table = self.expensesTable {
        //    return table.count
        //}
        return (self.categoriesTable?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        
        cell.DescriptionLabel.text = self.categoriesTable?[indexPath.row].name
        cell.CategoryImage.image = UIImage(named: "food_icon") //categoriesTable[indexPath.row].image
        
        return cell
    }
    
}
