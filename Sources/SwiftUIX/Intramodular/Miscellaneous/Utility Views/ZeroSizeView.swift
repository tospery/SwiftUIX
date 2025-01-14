//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(macOS) || os(tvOS) || targetEnvironment(macCatalyst)

import Swift
import SwiftUI

/// A zero-size view for when `EmptyView` just doesn't work.
fileprivate struct _ZeroSizeView: SwiftUIX_Hi.AppKitOrUIKitViewRepresentable {
    final class SwiftUIX_Hi.AppKitOrUIKitViewType: SwiftUIX_Hi.AppKitOrUIKitView {
        public override var intrinsicContentSize: CGSize {
            .zero
        }
        
        #if os(macOS)
        override var acceptsFirstResponder: Bool {
            false
        }

        override var fittingSize: NSSize {
            .zero
        }

        override var needsUpdateConstraints: Bool {
            get {
                false
            } set {
                if super.needsUpdateConstraints {
                    super.needsUpdateConstraints = false
                }
            }
        }
        #endif
        
        override init(frame: CGRect) {
            super.init(frame: .zero)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        
        override func invalidateIntrinsicContentSize() {
            
        }
        
        #if os(iOS)
        override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
            .zero
        }
        
        override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
            .zero
        }
        #elseif os(macOS)
        override func updateConstraintsForSubtreeIfNeeded() {
            
        }
        #endif
    }
    
    init() {
        
    }
    
    func makeSwiftUIX_Hi.AppKitOrUIKitView(
        context: Context
    ) -> SwiftUIX_Hi.AppKitOrUIKitViewType {
        let view = SwiftUIX_Hi.AppKitOrUIKitViewType()
        
        #if os(iOS)
        view.isAccessibilityElement = false
        view.isHidden = true
        view.isOpaque = true
        view.isUserInteractionEnabled = false
        
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentHuggingPriority(.required, for: .vertical)
        #endif
        
        view.frame.size = .zero
        
        return view
    }
    
    func updateSwiftUIX_Hi.AppKitOrUIKitView(
        _ view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        context: Context
    ) {
        view.frame.size = .zero
    }
    
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    func sizeThatFits(
        _ proposal: ProposedViewSize,
        view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        context: Context
    ) -> CGSize? {
        .zero
    }
}

@frozen
@_documentation(visibility: internal)
public struct ZeroSizeView: View {
    public var body: some View {
        _ZeroSizeView()
            .frame(width: 0, height: 0)
            .clipped()
            .allowsHitTesting(false)
            .accessibility(hidden: true)
    }
    
    public init() {
        
    }
}

#else

/// A zero-size view for when `EmptyView` just doesn't work.
@frozen
@_documentation(visibility: internal)
public struct ZeroSizeView: View {
    public var body: some View {
        Color.almostClear
            .frame(width: 0, height: 0)
            .allowsHitTesting(false)
            .accessibility(hidden: true)
    }
    
    public init() {
        
    }
}

#endif
