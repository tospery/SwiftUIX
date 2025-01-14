//
// Copyright (c) Vatsal Manot
//

#if canImport(UIKit)

import Swift
import UIKit

extension SwiftUIX_Hi.AppKitOrUIKitFont {
    public func withSymbolicTraits(
        _ traits: UIFontDescriptor.SymbolicTraits
    ) -> SwiftUIX_Hi.AppKitOrUIKitFont? {
        return fontDescriptor
            .withSymbolicTraits(traits)
            .map({ UIFont(descriptor: $0, size: 0) })
    }
    
    public func addingAttributes(
        _ attributes: [UIFontDescriptor.AttributeName: Any]
    ) -> SwiftUIX_Hi.AppKitOrUIKitFont {
        return .init(
            descriptor: fontDescriptor.addingAttributes(attributes),
            size: 0
        )
    }
    
    public var bold: SwiftUIX_Hi.AppKitOrUIKitFont! {
        return withSymbolicTraits(.traitBold)
    }
    
    public var italic: SwiftUIX_Hi.AppKitOrUIKitFont! {
        return withSymbolicTraits(.traitItalic)
    }
    
    public var monospaced: SwiftUIX_Hi.AppKitOrUIKitFont {
        let settings: [UIFontDescriptor.FeatureKey: Any]
        
        if #available(visionOS 1.0, *) {
            settings = [:]
            
            return withSymbolicTraits(.traitMonoSpace) ?? self
        } else {
            settings = [
                .featureIdentifier: kNumberSpacingType,
                .typeIdentifier: kMonospacedNumbersSelector
            ]
            
            return addingAttributes([.featureSettings: [settings]])
        }
    }
}

#endif
