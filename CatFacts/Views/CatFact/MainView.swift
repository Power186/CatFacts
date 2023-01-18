import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var catFactVM: CatFactViewModel
    
    @State private var isSettingsMenuShowing: Bool = false
    
    private let size = ImageSize(width: 300, height: 400)
    private let spacing: CGFloat = 24
    private let opacity: CGFloat = 0.5
    private let lineSpacing: CGFloat = 8
    private let fontSize: CGFloat = 18
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                if catFactVM.isLoading {
                    ActivityIndicator(isAnimating: $catFactVM.isLoading,
                                      style: .large,
                                      color: .systemMint)
                } else {
                    configureCatFactsView()
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                catFactVM.getCatFact()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    settingsButon()
                }
            }
        }
    }
    
}

// MARK: - View Extensions

extension MainView {
    
    @ViewBuilder
    private func settingsButon() -> some View {
        Button {
            isSettingsMenuShowing = true
        } label: {
            Image(systemName: Constants.gear)
                .imageScale(.large)
                .foregroundColor(Color(uiColor: .systemGray))
        }
        .sheet(isPresented: $isSettingsMenuShowing) {
            isSettingsMenuShowing = false
        } content: {
            UserSettingsView()
        }
    }
    
    @ViewBuilder
    private func configureCatFactsView() -> some View {
        if catFactVM.catFact.isEmpty {
            EmptyStateView(message: Constants.noCatFacts,
                           image: Constants.network)
        } else {
            VStack(spacing: spacing) {
                Text(Constants.mainUserDirection)
                    .font(.system(size: fontSize))
                    .foregroundColor(.secondary)
                    .opacity(opacity)
                
                AsyncImageView(width: size.width,
                               height: size.height)
                
                ScrollView(.vertical) {
                    Text(catFactVM.catFact)
                        .font(.system(size: fontSize,
                                      weight: .regular,
                                      design: .rounded))
                        .lineSpacing(lineSpacing)
                }
                .padding([.leading, .trailing], spacing)
            }
        }
    }
    
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
            .environmentObject(CatFactViewModel())
    }
    
}
