//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(macOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)

import SwiftUI

@_documentation(visibility: internal)
public struct SwiftUIX_Hi.AppKitOrUIKitViewAdaptor<Base: SwiftUIX_Hi.AppKitOrUIKitView>: SwiftUIX_Hi.AppKitOrUIKitViewRepresentable {
#if os(iOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
    public typealias UIViewType = Base
#elseif os(macOS)
    public typealias NSViewType = Base
#endif
    
    public typealias SwiftUIX_Hi.AppKitOrUIKitViewType = Base
    
    fileprivate let _makeView: (Context) -> SwiftUIX_Hi.AppKitOrUIKitViewType
    fileprivate let _updateView: (SwiftUIX_Hi.AppKitOrUIKitViewType, Context) -> ()
    fileprivate let _sizeThatFits: ((_SwiftUIX_ProposedSize, SwiftUIX_Hi.AppKitOrUIKitViewType, Context) -> CGSize?)?
    
    public init(
        _ makeView: @escaping () -> SwiftUIX_Hi.AppKitOrUIKitViewType
    ) {
        self._makeView = { _ in makeView() }
        self._updateView = { _, _ in }
        self._sizeThatFits = nil
    }
    
    public func makeSwiftUIX_Hi.AppKitOrUIKitView(
        context: Context
    ) -> SwiftUIX_Hi.AppKitOrUIKitViewType {
        _makeView(context)
    }
    
    public func updateSwiftUIX_Hi.AppKitOrUIKitView(
        _ view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        context: Context
    ) {
        _updateView(view, context)
    }
}

#if os(macOS)
extension SwiftUIX_Hi.AppKitOrUIKitViewAdaptor {
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public func sizeThatFits(
        _ proposal: ProposedViewSize,
        nsView: Base,
        context: Context
    ) -> CGSize? {
        if let _sizeThatFits {
            return _sizeThatFits(.init(proposal), nsView, context)
        } else {
            return nsView.intrinsicContentSize
        }
    }
}
#endif

#endif
