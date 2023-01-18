import Foundation

enum LanguageSelection: String, CaseIterable {
    
    case english = "eng-us"
    case german = "ger-de"
    case spanish = "esp-mx"
    case filipino = "tl-fil"
    
    func displayLanguageNames() -> String {
        switch self {
        case .english:
            return Constants.english
        case .german:
            return Constants.german
        case .spanish:
            return Constants.spanish
        case .filipino:
            return Constants.filipino
        }
    }
    
}
