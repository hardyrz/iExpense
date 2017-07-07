import UIKit
import RealmSwift
import Charts

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var pieView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateChartWithData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateChartWithData() {
        var dataEntries: [PieChartDataEntry] = []
        let categories = getCategories()
        for i in 0..<categories.count {
            let expensesAmount = getExpenseCountsByCategory(category: categories[i])
            
            let dataEntry = PieChartDataEntry(value: Double(expensesAmount), label: categories[i].name)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Categories")
        pieChartDataSet.sliceSpace = 2
        pieChartDataSet.colors = [UIColor.red, UIColor.gray, UIColor.blue, UIColor.green]
        
        self.pieView.data = PieChartData(dataSet: pieChartDataSet)
    }
    
    func getExpenseCountsByCategory(category : CategoryDTO) -> Int {
        do {
            let realm = try Realm()
            let expenses = realm.objects(ExpenseDTO.self)
            var amount = 0
            for i in 0..<expenses.count {
                if (expenses[i].category == category) {
                    amount += expenses[i].value
                }
            }
            return amount
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func getCategories() -> Results<CategoryDTO> {
        do {
            let realm = try Realm()
            return realm.objects(CategoryDTO.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
