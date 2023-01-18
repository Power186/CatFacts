import SwiftUI

struct AsyncImageView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var imageVM: AsyncImageViewModel
    
    let width: Int
    let height: Int
    
    private let cornerRadius: CGFloat = 8
    private let opacity: CGFloat = 0.0
    
    // MARK: - Initialization
    
    init(width: Int, height: Int) {
        _imageVM = ObservedObject(wrappedValue: AsyncImageViewModel())
        self.width = width
        self.height = height
    }
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            if let renderImage = imageVM.image {
                Image(uiImage: renderImage)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: CGFloat(width),
                           height: CGFloat(height))
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .aspectRatio(contentMode: .fit)
            } else {
                imagePlaceholderAreaView()
            }
        }
    }
}

// MARK: - View Extensions

extension AsyncImageView {
    
    @ViewBuilder
    private func imagePlaceholderAreaView() -> some View {
        Image(systemName: Constants.rectangle)
            .resizable()
            .frame(width: CGFloat(width),
                   height: CGFloat(width))
            .opacity(opacity)
    }
    
}

// MARK: - Preview

struct AsyncImageView_Previews: PreviewProvider {
    
    static var previews: some View {
        AsyncImageView(width: 200, height: 300)
    }
    
}
