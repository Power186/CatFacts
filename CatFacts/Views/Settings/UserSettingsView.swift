import SwiftUI

struct UserSettingsView: View {
    
    // MARK: - Properties
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject private var catFactVM: CatFactViewModel
    
    @AppStorage(Constants.lightDarkMode) private var isDarkMode: Bool = false
    
    private let time: CGFloat = 0.35
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    languagePicker()
                           .onChange(of: catFactVM.language) { _ in
                               catFactVM.getCatFact()
                               SessionManager.dispatchMain(afterTime: time) {
                                   presentation.wrappedValue.dismiss()
                               }
                           }
                } header: {
                    Text(Constants.languageTitle)
                }
                
                Section {
                    lightDarkModePicker()
                        .onChange(of: isDarkMode) { _ in
                            SessionManager.dispatchMain(afterTime: time) {
                                presentation.wrappedValue.dismiss()
                            }
                        }
                } header: {
                    Text(Constants.modeTitle)
                }
            }
            .navigationTitle(Text(Constants.settingsTitle))
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
    
}

// MARK: - View Extensions

extension UserSettingsView {
    
    @ViewBuilder
    private func languagePicker() -> some View {
        Picker(Constants.seclectTitle,
               selection: $catFactVM.language) {
            ForEach(LanguageSelection.allCases, id: \.self) {
                Text($0.displayLanguageNames())
            }
        }
    }
    
    @ViewBuilder
    private func lightDarkModePicker() -> some View {
        Picker(selection: $isDarkMode) {
            Text(Constants.light)
                .fontWeight(.semibold)
                .tag(false)
            Text(Constants.dark)
                .fontWeight(.semibold)
                .tag(true)
        } label: { }
        .pickerStyle(.segmented)
    }
    
}

// MARK: - Preview

struct UserSettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        UserSettingsView()
            .environmentObject(CatFactViewModel())
    }
    
}
