//
// Copyright (c) Vatsal Manot
//

import Dispatch
import Swift
import SwiftUI

#if os(iOS) || os(macOS) || os(tvOS) || targetEnvironment(macCatalyst)

@_documentation(visibility: internal)
public struct AttributedText: SwiftUIX_Hi.AppKitOrUIKitViewRepresentable {
    public typealias SwiftUIX_Hi.AppKitOrUIKitViewType = SwiftUIX_Hi.AppKitOrUIKitLabel
    
    fileprivate struct Configuration: Hashable {
        var appKitOrUIKitFont: SwiftUIX_Hi.AppKitOrUIKitFont?
        var appKitOrUIKitForegroundColor: SwiftUIX_Hi.AppKitOrUIKitColor?
    }
    
    @Environment(\.accessibilityEnabled) fileprivate var accessibilityEnabled
    @Environment(\.adjustsFontSizeToFitWidth) fileprivate var adjustsFontSizeToFitWidth
    @Environment(\.allowsTightening) fileprivate var allowsTightening
    @Environment(\.font) fileprivate var font
    @Environment(\.isEnabled) fileprivate var isEnabled
    @Environment(\.lineBreakMode) fileprivate var lineBreakMode
    @Environment(\.lineLimit) fileprivate var lineLimit
    @Environment(\.minimumScaleFactor) fileprivate var minimumScaleFactor
    @Environment(\.preferredMaximumLayoutWidth) fileprivate var preferredMaximumLayoutWidth
    #if os(macOS)
    @Environment(\.layoutDirection) fileprivate var layoutDirection
    #endif
    
    public let content: NSAttributedString
    
    fileprivate var configuration = Configuration()
    
    public init(
        _ content: NSAttributedString
    ) {
        self.content = content
    }
    
    public init<S: StringProtocol>(
        _ content: S
    ) {
        self.init(NSAttributedString(string: String(content)))
    }
    
    public func makeSwiftUIX_Hi.AppKitOrUIKitView(
        context: Context
    ) -> SwiftUIX_Hi.AppKitOrUIKitViewType {
        SwiftUIX_Hi.AppKitOrUIKitViewType()
    }
    
    public func updateSwiftUIX_Hi.AppKitOrUIKitView(
        _ view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        context: Context
    ) {
        DispatchQueue.asyncOnMainIfNecessary {
            view.configure(with: self)
        }
    }
}

// MARK: - API

extension AttributedText {
    public func font(_ font: SwiftUIX_Hi.AppKitOrUIKitFont) -> Self {
        then({ $0.configuration.appKitOrUIKitFont = font })
    }
    
    public func foregroundColor(_ foregroundColor: SwiftUIX_Hi.AppKitOrUIKitColor) -> Self {
        then({ $0.configuration.appKitOrUIKitForegroundColor = foregroundColor })
    }
    
    #if os(iOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
    @_disfavoredOverload
    public func foregroundColor(_ foregroundColor: Color?) -> Self {
        then({ $0.configuration.appKitOrUIKitForegroundColor = foregroundColor?.toUIColor() })
    }
    #endif
}

// MARK: - Auxiliary

extension SwiftUIX_Hi.AppKitOrUIKitLabel {
    func configure(with attributedText: AttributedText) {
        #if os(iOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
        self.allowsDefaultTighteningForTruncation = attributedText.allowsTightening
        #endif
        self.font = attributedText.configuration.appKitOrUIKitFont ?? self.font
        self.adjustsFontSizeToFitWidth = attributedText.adjustsFontSizeToFitWidth
        self.lineBreakMode = attributedText.lineBreakMode
        self.minimumScaleFactor = attributedText.minimumScaleFactor
        self.numberOfLines = attributedText.lineLimit ?? 0
        self.textColor = attributedText.configuration.appKitOrUIKitForegroundColor ?? self.textColor
        
        #if os(macOS)
        self.setAccessibilityEnabled(attributedText.accessibilityEnabled)
        self.userInterfaceLayoutDirection = .init(attributedText.layoutDirection)
        #endif
        
        #if os(iOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
        if let font = try? attributedText.configuration.appKitOrUIKitFont ?? attributedText.font?.toSwiftUIX_Hi.AppKitOrUIKitFont() {
            let string = NSMutableAttributedString(attributedString: attributedText.content)
            
            string.addAttribute(.font, value: font, range: .init(location: 0, length: string.length))
            
            self.attributedText = attributedText.content
        } else {
            self.attributedText = attributedText.content
        }
        #else
        self.attributedText = attributedText.content
        #endif
        
        if 
            let preferredMaximumLayoutWidth = attributedText.preferredMaximumLayoutWidth,
            preferredMaxLayoutWidth != attributedText.preferredMaximumLayoutWidth
        {
            preferredMaxLayoutWidth = preferredMaximumLayoutWidth
            
            frame.size.width = min(frame.size.width, preferredMaximumLayoutWidth)
            
            _SwiftUIX_layoutIfNeeded()
        }
        
        setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        setContentHuggingPriority(.defaultHigh, for: .horizontal)
        setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}

#endif
