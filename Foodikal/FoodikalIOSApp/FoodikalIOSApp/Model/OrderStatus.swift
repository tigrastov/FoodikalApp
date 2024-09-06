
import Foundation
import SwiftUI

enum OrderStatus: String, CaseIterable{
    case new = "New"
    case cooking = "In progress"
    case delivery = "Delivery"
    case completed = "Completed"
    case cancelled = "Canceled"
} 
