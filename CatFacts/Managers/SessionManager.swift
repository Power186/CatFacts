import Foundation
import Combine

struct SessionManager {
    
    static func configureData(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 &&
                response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
    static func dispatchMain(afterTime: CGFloat, execute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + afterTime) {
            execute()
        }
    }
    
}
