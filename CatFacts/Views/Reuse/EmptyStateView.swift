import SwiftUI

struct EmptyStateView: View {
    
    // MARK: - Properties
    
    let message: String
    let image: String
    
    private let size = ImageSize(width: 100, height: 100)
    private let fontSize: CGFloat = 26
    private let spacing: CGFloat = 16
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: spacing) {
            Image(systemName: image)
                .resizable()
                .frame(width: CGFloat(size.width),
                       height: CGFloat(size.height))
            Text(message)
                .font(.system(size: fontSize,
                              weight: .semibold,
                              design: .rounded))
        }
    }
}

// MARK: - Preview

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(message: "Empty State Preview",
                       image: "camera.circle.fill")
    }
}
