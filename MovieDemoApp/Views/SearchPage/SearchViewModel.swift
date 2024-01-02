import Foundation
import Observation

@Observable
final class SearchViewModel {
    var searchTxt: String = ""
    var categories: [String] = ["Motivation", "Songs", "Tips", "Exercise"]
    var pinsSelection: Pins = .all
    
    enum Pins: String, CaseIterable, Identifiable {
        case all, your
        
        var id: String { rawValue }
        
        var capitalized: String {
            return self.rawValue.prefix(1).capitalized + self.rawValue.dropFirst()
        }
    }
}
