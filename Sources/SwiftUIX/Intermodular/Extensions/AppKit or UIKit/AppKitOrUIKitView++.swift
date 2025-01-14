//
// Copyright (c) Vatsal Manot
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
extension SwiftUIX_Hi.AppKitOrUIKitView {
    public func _SwiftUIX_setNeedsDisplay() {
        
    }
    
    public func _SwiftUIX_setNeedsLayout() {
        setNeedsLayout()
    }
    
    public func _SwiftUIX_layoutIfNeeded() {
        layoutIfNeeded()
    }
}
#elseif os(macOS)
extension SwiftUIX_Hi.AppKitOrUIKitView {
    public func _SwiftUIX_setNeedsDisplay() {
        needsDisplay = true
    }
    
    public func _SwiftUIX_setNeedsLayout() {
        needsLayout = true
    }
    
    public func _SwiftUIX_layoutIfNeeded() {
        layout()
    }
}
#endif

#if os(iOS) || os(macOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
extension SwiftUIX_Hi.AppKitOrUIKitView {
    @usableFromInline
    var isHorizontalContentHuggingPriorityHigh: Bool {
        contentHuggingPriority(for: .horizontal) == .defaultHigh
    }
    
    @usableFromInline
    var isVerticalContentHuggingPriorityHigh: Bool {
        contentHuggingPriority(for: .vertical) == .defaultHigh
    }
    
    func _UIKit_only_sizeToFit() {
        #if os(iOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
        sizeToFit()
        #endif
    }
}

extension SwiftUIX_Hi.AppKitOrUIKitView {
    public func _SwiftUIX_findSubview<T: SwiftUIX_Hi.AppKitOrUIKitView>(
        ofKind kind: T.Type
    ) -> T? {
        findSubview(ofKind: kind)
    }
    
    public func _SwiftUIX_findSubview(
        where predicate: (SwiftUIX_Hi.AppKitOrUIKitView) -> Bool
    ) -> SwiftUIX_Hi.AppKitOrUIKitView? {
        findSubview(where: predicate)
    }
    
    private func findSubview<T: SwiftUIX_Hi.AppKitOrUIKitView>(
        ofKind kind: T.Type
    ) -> T? {
        guard !subviews.isEmpty else {
            return nil
        }
        
        for subview in subviews {
            if subview.isKind(of: kind) {
                return subview as? T
            } else if let result = subview.findSubview(ofKind: kind) {
                return result
            }
        }
        
        return nil
    }
    
    private func findSubview(
        where predicate: (SwiftUIX_Hi.AppKitOrUIKitView) -> Bool
    ) -> SwiftUIX_Hi.AppKitOrUIKitView? {
        guard !subviews.isEmpty else {
            return nil
        }
        
        for subview in subviews {
            if predicate(subview) {
                return subview
            } else if let result = subview.findSubview(where: predicate) {
                return result
            }
        }
        
        return nil
    }
}
#endif
