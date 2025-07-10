import Foundation

enum TimeFilter: String, CaseIterable {
    case h24 = "24H"
    case w1 = "1W"
    case y1 = "1Y"
    case all = "ALL"
    case point = "Point"
}
