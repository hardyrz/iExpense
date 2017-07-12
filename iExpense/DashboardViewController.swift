import UIKit
import RealmSwift
import Charts

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var pieView: PieChartView!
    @IBOutlet weak var barView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateChartWithData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateChartWithData()
        updateBarChartWithData()
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
        pieChartDataSet.colors = [UIColor.magenta, UIColor.orange, UIColor.black, UIColor.brown, UIColor.red, UIColor.blue, UIColor.green, UIColor.gray]
        
        self.pieView.data = PieChartData(dataSet: pieChartDataSet)
        self.pieView.chartDescription?.text = "All time expenses"
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
    
    // Bar Chart
    func updateBarChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        let expenses = getExpensesFromDatabase()
        var months = [0,0,0,
                      0,0,0,
                      0,0,0,
                      0,0,0]
        var monthsStrings = ["Jan","Feb","Mar",
                             "Apr","May","Jun",
                             "Jul","Aug","Sep",
                             "Oct","Nov","Dec"]
        
        let calendar = Calendar.current
        
        for i in 0..<expenses.count {
            let month = calendar.component(.month, from: expenses[i].date!)
            months[month] += expenses[i].value
        }
        
        for j in 0..<months.count {
            let dataEntry = BarChartDataEntry(x: Double(j), y: Double(months[j]))
            dataEntries.append(dataEntry)
        }
        
        
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "2017")
        let chartData = BarChartData(dataSet: chartDataSet)
        barView.data = chartData
        barView.noDataText = "You need to provide data for the chart."
    }
    
    
    func getExpensesFromDatabase() -> Results<ExpenseDTO> {
        do {
            let realm = try Realm()
            return realm.objects(ExpenseDTO.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
