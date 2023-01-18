import SwiftUI
import Combine

final class AsyncImageViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var isLoading: Bool = false
    @Published var image: UIImage? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    init() {
        getImage()
    }
    
    // MARK: - Methods
    
    func getImage() {
        do {
            try downloadImage()
        } catch let error {
            log(error.localizedDescription)
        }
    }
    
}

// MARK: - Extensions

extension AsyncImageViewModel {
    
    private func downloadImage() throws {
        let randomNumber = Int.random(in: 1..<15)
        
        guard let url = URL(string: "https://placekitten.com/200/300?image=\(randomNumber)") else {
            isLoading = false
            throw URLError(.badURL)
        }
        
        isLoading = true
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(SessionManager.configureData)
            .map { UIImage(data: $0) }
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
                guard let self = self,
                      let returnedImage = $0 else { return }
                self.image = returnedImage
            }
            .store(in: &cancellables)
    }
    
}
