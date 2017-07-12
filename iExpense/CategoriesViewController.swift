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
        self.navigationController?.tabBarItem.image = UIImage(named: "category_icon")
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
        return (self.categoriesTable?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        
        cell.DescriptionLabel.text = self.categoriesTable?[indexPath.row].name
        let cat = self.categoriesTable?[indexPath.row].name
        let letter = cat?.index((cat?.startIndex)!, offsetBy: 1)
        
        cell.categoryLabel.text = cat?.substring(to: letter!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let filter = "name == '" + (self.categoriesTable?[indexPath.row].name)! + "'"
            let categoryToDelete = realm.objects(CategoryDTO.self).filter(filter)
            
            try! realm.write {
                realm.delete(categoryToDelete)
            }
            tableView.reloadData()
        }
    }
    
}
