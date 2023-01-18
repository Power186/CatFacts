import XCTest
@testable import CatFacts

final class LanguageSelectionTests: XCTestCase {
    
    var languageSelection: LanguageSelection!

    override func setUpWithError() throws {
        try super.setUpWithError()
        languageSelection = LanguageSelection.english
    }

    override func tearDownWithError() throws {
        languageSelection = nil
        try super.tearDownWithError()
    }

    func testCases() throws {
        let english = languageSelection.rawValue
        XCTAssertEqual(english, "eng-us")

        languageSelection = LanguageSelection.spanish

        let spanish = languageSelection.rawValue
        XCTAssertEqual(spanish, "esp-mx")

        languageSelection = LanguageSelection.german

        let german = languageSelection.rawValue
        XCTAssertEqual(german, "ger-de")

        languageSelection = LanguageSelection.filipino

        let filipino = languageSelection.rawValue
        XCTAssertEqual(filipino, "tl-fil")
    }
    
    func testDisplayNames() throws {
        var arrayResult: [String] = []
        
        LanguageSelection.allCases.forEach {
            arrayResult.append($0.displayLanguageNames())
        }
        
        XCTAssertEqual(arrayResult[0], "English")
        XCTAssertEqual(arrayResult[1], "German")
        XCTAssertEqual(arrayResult[2], "Spanish")
        XCTAssertEqual(arrayResult[3], "Filipino")
    }

}
