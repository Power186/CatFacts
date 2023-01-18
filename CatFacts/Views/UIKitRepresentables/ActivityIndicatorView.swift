import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    typealias IndicatorView = UIActivityIndicatorView
    
    // MARK: - Properties
    
    @Binding var isAnimating: Bool
    
    var style: UIActivityIndicatorView.Style
    var color: UIColor
    
    // MARK: - Initialization
    
    init(isAnimating: Binding<Bool>,
         style: UIActivityIndicatorView.Style,
         color: UIColor) {
        self._isAnimating = isAnimating
        self.style = style
        self.color = color
    }
    
    // MARK: - Methods
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> IndicatorView {
        let view = IndicatorView(style: style)
        view.color = color
        return view
    }
    
    func updateUIView(_ uiView: IndicatorView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
    
}
