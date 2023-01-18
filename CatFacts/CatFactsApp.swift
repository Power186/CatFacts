import SwiftUI

@main
struct CatFactsApp: App {
    
    // MARK: - Properties
    
    @AppStorage(Constants.lightDarkMode) private var isDarkMode: Bool = false
    
    let catFactVM: CatFactViewModel = CatFactViewModel()
    
    // MARK: - App Entry
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.colorScheme, isDarkMode ? .dark : .light)
                .environmentObject(catFactVM)
        }
    }
    
}
