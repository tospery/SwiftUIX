//
// Copyright (c) Vatsal Manot
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
extension SwiftUIX_Hi.AppKitOrUIKitFont {
    public var _SwiftUIX_estimatedLineHeight: CGFloat {
        fatalError("unimplemented")
    }

    func scaled(
        by ratio: CGFloat
    ) -> SwiftUIX_Hi.AppKitOrUIKitFont {
        let newPointSize = pointSize * ratio
        
        return SwiftUIX_Hi.AppKitOrUIKitFont(
            descriptor: fontDescriptor,
            size: newPointSize
        )
    }
}
#elseif os(macOS)
extension SwiftUIX_Hi.AppKitOrUIKitFont {
    public var _SwiftUIX_estimatedLineHeight: CGFloat {
        floor(ascender + abs(descender) + leading)
    }

    func scaled(
        by ratio: CGFloat
    ) -> NSFont {
        let newPointSize = pointSize * ratio
        
        guard let font = NSFont(
            descriptor: fontDescriptor,
            size: newPointSize
        ) else {
            assertionFailure()
            
            return self
        }
        
        return font
    }
}
#endif
