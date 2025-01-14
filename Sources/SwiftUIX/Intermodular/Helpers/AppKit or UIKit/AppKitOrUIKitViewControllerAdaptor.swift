//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(macOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)

import SwiftUI

@_documentation(visibility: internal)
public struct SwiftUIX_Hi.AppKitOrUIKitViewControllerAdaptor<SwiftUIX_Hi.AppKitOrUIKitViewControllerType: SwiftUIX_Hi.AppKitOrUIKitViewController>: SwiftUIX_Hi.AppKitOrUIKitViewControllerRepresentable {
#if os(iOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
    public typealias UIViewControllerType = SwiftUIX_Hi.AppKitOrUIKitViewControllerType
#elseif os(macOS)
    public typealias NSViewControllerType = SwiftUIX_Hi.AppKitOrUIKitViewControllerType
#endif
    
    private let makeSwiftUIX_Hi.AppKitOrUIKitViewControllerImpl: (Context) -> SwiftUIX_Hi.AppKitOrUIKitViewControllerType
    private let updateSwiftUIX_Hi.AppKitOrUIKitViewControllerImpl: (SwiftUIX_Hi.AppKitOrUIKitViewControllerType, Context) -> ()
    
    public init(
        _ makeController: @autoclosure @escaping () -> SwiftUIX_Hi.AppKitOrUIKitViewControllerType
    ) {
        self.makeSwiftUIX_Hi.AppKitOrUIKitViewControllerImpl = { _ in makeController() }
        self.updateSwiftUIX_Hi.AppKitOrUIKitViewControllerImpl = { _, _ in }
    }
    
    public init(
        _ makeController: @escaping () -> SwiftUIX_Hi.AppKitOrUIKitViewControllerType
    ) {
        self.makeSwiftUIX_Hi.AppKitOrUIKitViewControllerImpl = { _ in makeController() }
        self.updateSwiftUIX_Hi.AppKitOrUIKitViewControllerImpl = { _, _ in }
    }
    
    public func makeSwiftUIX_Hi.AppKitOrUIKitViewController(
        context: Context
    ) -> SwiftUIX_Hi.AppKitOrUIKitViewControllerType {
        makeSwiftUIX_Hi.AppKitOrUIKitViewControllerImpl(context)
    }
    
    public func updateSwiftUIX_Hi.AppKitOrUIKitViewController(
        _ uiViewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType,
        context: Context
    ) {
        updateSwiftUIX_Hi.AppKitOrUIKitViewControllerImpl(uiViewController, context)
    }
}

#endif
