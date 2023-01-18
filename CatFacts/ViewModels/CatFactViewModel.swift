import SwiftUI
import Combine

final class CatFactViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var isLoading: Bool = false
    @Published var catFact: String = String()
    @Published var language: LanguageSelection {
        didSet {
            UserDefaults.standard.set(language.rawValue, forKey: Constants.language)
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    init() {
        language = LanguageSelection(rawValue: UserDefaults.standard.string(forKey: Constants.language) ?? "") ?? .english
        getCatFact()
    }
    
    // MARK: - Methods
    
    func getCatFact() {
        guard let url = URL(string: "https://meowfacts.herokuapp.com/?lang=\(language.rawValue)") else {
            log("\(URLError.badURL)")
            return
        }
        
        withAnimation { isLoading = true }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(SessionManager.configureData)
            .decode(type: CatFact.self,
                    decoder: JSONDecoder())
            .sink { [weak self] in
                guard let self = self else { return }
                switch $0 {
                case .finished:
                    self.isLoading = false
                    break
                case .failure(let error):
                    self.isLoading = false
                    log(error.localizedDescription)
                }
            } receiveValue: { [weak self] in
                guard let self = self else { return }
                self.catFact = $0.configureCatFact()
            }
            .store(in: &cancellables)
    }
    
}
