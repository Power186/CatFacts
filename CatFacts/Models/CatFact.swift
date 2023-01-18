import Foundation

struct CatFact: Codable {
    
    var catData: [String]
    
    private enum CodingKeys: String, CodingKey {
        case catData = "data"
    }
    
}

// MARK: - Extensions

extension CatFact {
    
    func configureCatFact() -> String {
        guard let first = catData.first else {
            return String()
        }
        return first
    }
    
}
