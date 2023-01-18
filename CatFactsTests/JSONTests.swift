import XCTest
@testable import CatFacts

final class JSONTests: XCTestCase {
    
    var response: JSONResponse!

    override func setUpWithError() throws {
        try super.setUpWithError()
        response = JSONResponse()
    }

    override func tearDownWithError() throws {
        response = nil
        try super.tearDownWithError()
    }

    func testCatFactJSONDecoding() throws {
        let decoded = try JSONDecoder().decode(CatFact.self,
                                               from: response.catFactsModel)
        XCTAssertNoThrow(decoded, "Cat facts should not throw decoding errors")
        
        decoded.catData.forEach {
            XCTAssertEqual($0, "Mother cats teach their kittens to use the litter box.")
        }
    }

}
