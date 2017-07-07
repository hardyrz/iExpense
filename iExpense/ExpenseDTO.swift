import Foundation
import RealmSwift

class ExpenseDTO : Object {
    dynamic var value = 0
    dynamic var desc = ""
    dynamic var category: CategoryDTO?
    dynamic var account: AccountDTO?
    dynamic var date: Date?
}
