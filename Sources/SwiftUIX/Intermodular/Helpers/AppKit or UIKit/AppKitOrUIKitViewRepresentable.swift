//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

/// A Cocoa-touch view/view controller representable.
public protocol _AppKitOrUIKitRepresentable {
    associatedtype Coordinator
}

public protocol _AppKitOrUIKitViewRepresentableContext<Coordinator> {
    associatedtype Coordinator
    
    var coordinator: Coordinator { get }
    var transaction: Transaction { get }
    var environment: EnvironmentValues { get }
}

#if os(iOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
public protocol AppKitOrUIKitViewRepresentable: _AppKitOrUIKitRepresentable, UIViewRepresentable {
    associatedtype AppKitOrUIKitViewType = UIViewType where SwiftUIX_Hi.AppKitOrUIKitViewType == UIViewType
    
    @MainActor
    func makeAppKitOrUIKitView(context: Context) -> SwiftUIX_Hi.AppKitOrUIKitViewType
    
    @MainActor
    func updateAppKitOrUIKitView(_ view: SwiftUIX_Hi.AppKitOrUIKitViewType, context: Context)
    
    @MainActor
    static func dismantleSwiftUIX_Hi.AppKitOrUIKitView(_ view: SwiftUIX_Hi.AppKitOrUIKitViewType, coordinator: Coordinator)
    
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    @MainActor
    func sizeThatFits(
        _ proposal: ProposedViewSize,
        view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        context: Context
    ) -> CGSize?
}

public protocol SwiftUIX_Hi.AppKitOrUIKitViewControllerRepresentable: _AppKitOrUIKitRepresentable, UIViewControllerRepresentable {
    associatedtype SwiftUIX_Hi.AppKitOrUIKitViewControllerType = UIViewControllerType where SwiftUIX_Hi.AppKitOrUIKitViewControllerType == UIViewControllerType
    
    @MainActor
    func makeSwiftUIX_Hi.AppKitOrUIKitViewController(context: Context) -> SwiftUIX_Hi.AppKitOrUIKitViewControllerType
    @MainActor
    func updateSwiftUIX_Hi.AppKitOrUIKitViewController(_ viewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType, context: Context)
    
    @MainActor
    static func dismantleSwiftUIX_Hi.AppKitOrUIKitViewController(
        _ view: SwiftUIX_Hi.AppKitOrUIKitViewControllerType,
        coordinator: Coordinator
    )
    
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    @MainActor
    func sizeThatFits(
        _ proposal: ProposedViewSize,
        viewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType,
        context: Context
    ) -> CGSize?
}
#elseif os(macOS)
public protocol SwiftUIX_Hi.AppKitOrUIKitViewRepresentable: _AppKitOrUIKitRepresentable, NSViewRepresentable {
    associatedtype SwiftUIX_Hi.AppKitOrUIKitViewType where SwiftUIX_Hi.AppKitOrUIKitViewType == NSViewType
    
    @MainActor
    func makeSwiftUIX_Hi.AppKitOrUIKitView(context: Context) -> SwiftUIX_Hi.AppKitOrUIKitViewType
    @MainActor
    func updateSwiftUIX_Hi.AppKitOrUIKitView(_ view: SwiftUIX_Hi.AppKitOrUIKitViewType, context: Context)
    
    @MainActor
    static func dismantleSwiftUIX_Hi.AppKitOrUIKitView(_ view: SwiftUIX_Hi.AppKitOrUIKitViewType, coordinator: Coordinator)
    
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    @MainActor
    func sizeThatFits(
        _ proposal: ProposedViewSize,
        view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        context: Context
    ) -> CGSize?
}

public protocol SwiftUIX_Hi.AppKitOrUIKitViewControllerRepresentable: _AppKitOrUIKitRepresentable, NSViewControllerRepresentable {
    associatedtype SwiftUIX_Hi.AppKitOrUIKitViewControllerType = NSViewControllerType where SwiftUIX_Hi.AppKitOrUIKitViewControllerType == NSViewControllerType
    
    @MainActor
    func makeSwiftUIX_Hi.AppKitOrUIKitViewController(context: Context) -> SwiftUIX_Hi.AppKitOrUIKitViewControllerType
    @MainActor
    func updateSwiftUIX_Hi.AppKitOrUIKitViewController(_ viewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType, context: Context)
    
    @MainActor
    static func dismantleSwiftUIX_Hi.AppKitOrUIKitViewController(_ view: SwiftUIX_Hi.AppKitOrUIKitViewControllerType, coordinator: Coordinator)
    
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    @MainActor
    func sizeThatFits(
        _ proposal: ProposedViewSize,
        viewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType,
        context: Context
    ) -> CGSize?
}
#endif

// MARK: - Implementation

#if os(iOS) || os(macOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
extension SwiftUIX_Hi.AppKitOrUIKitViewRepresentable {
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    @MainActor
    public func sizeThatFits(
        _ proposal: ProposedViewSize,
        view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        context: Context
    ) -> CGSize? {
        nil
    }
}

extension SwiftUIX_Hi.AppKitOrUIKitViewControllerRepresentable {
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    @MainActor
    public func sizeThatFits(
        _ proposal: ProposedViewSize,
        viewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType,
        context: Context
    ) -> CGSize? {
        nil
    }
}
#endif

#if os(iOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
extension UIViewRepresentableContext: _AppKitOrUIKitViewRepresentableContext {
    
}

extension SwiftUIX_Hi.AppKitOrUIKitViewRepresentable {
    public typealias Context = UIViewRepresentableContext<Self>
    
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    @MainActor
    public func sizeThatFits(
        _ proposal: ProposedViewSize,
        uiView: SwiftUIX_Hi.AppKitOrUIKitViewType,
        context: Context
    ) -> CGSize? {
        self.sizeThatFits(proposal, view: uiView, context: context)
    }
}

extension SwiftUIX_Hi.AppKitOrUIKitViewRepresentable {
    @MainActor
    public func makeUIView(
        context: Context
    ) -> SwiftUIX_Hi.AppKitOrUIKitViewType {
        makeSwiftUIX_Hi.AppKitOrUIKitView(context: context)
    }
    
    @MainActor
    public func updateUIView(
        _ view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        context: Context
    ) {
        let represented = view as? _AppKitOrUIKitRepresented
        
        represented?.representatableStateFlags.insert(.updateInProgress)
        
        updateSwiftUIX_Hi.AppKitOrUIKitView(view, context: context)
        
        represented?.representatableStateFlags.remove(.updateInProgress)
        
        if let represented, !represented.representatableStateFlags.contains(.didUpdateAtLeastOnce) {
            represented.representatableStateFlags.insert(.didUpdateAtLeastOnce)
        }
    }
    
    @MainActor
    public static func dismantleUIView(
        _ view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        coordinator: Coordinator
    ) {
        let represented = view as? _AppKitOrUIKitRepresented
        
        dismantleSwiftUIX_Hi.AppKitOrUIKitView(view, coordinator: coordinator)
        
        represented?.representatableStateFlags.insert(.dismantled)
    }
}

extension SwiftUIX_Hi.AppKitOrUIKitViewRepresentable where SwiftUIX_Hi.AppKitOrUIKitViewType: _AppKitOrUIKitRepresented {
    @MainActor
    public func makeUIView(context: Context) -> SwiftUIX_Hi.AppKitOrUIKitViewType {
        makeSwiftUIX_Hi.AppKitOrUIKitView(context: context)
    }
    
    @MainActor
    public func updateUIView(
        _ view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        context: Context
    ) {
        view.representatableStateFlags.insert(.updateInProgress)
        
        updateSwiftUIX_Hi.AppKitOrUIKitView(view, context: context)
        
        view.representatableStateFlags.remove(.updateInProgress)
        
        if !view.representatableStateFlags.contains(.didUpdateAtLeastOnce) {
            view.representatableStateFlags.insert(.didUpdateAtLeastOnce)
        }
    }
    
    @MainActor
    public static func dismantleUIView(
        _ view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        coordinator: Coordinator
    ) {
        dismantleSwiftUIX_Hi.AppKitOrUIKitView(view, coordinator: coordinator)
        
        view.representatableStateFlags.insert(.dismantled)
    }
}

extension SwiftUIX_Hi.AppKitOrUIKitViewControllerRepresentable {
    public typealias Context = UIViewControllerRepresentableContext<Self>

    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    @MainActor
    public func sizeThatFits(
        _ proposal: ProposedViewSize,
        uiViewController: Self.UIViewControllerType,
        context: Self.Context
    ) -> CGSize? {
        self.sizeThatFits(
            proposal,
            viewController: uiViewController,
            context: context
        )
    }
}

extension SwiftUIX_Hi.AppKitOrUIKitViewControllerRepresentable {
    @MainActor
    public func makeUIViewController(
        context: Context
    ) -> SwiftUIX_Hi.AppKitOrUIKitViewControllerType {
        makeSwiftUIX_Hi.AppKitOrUIKitViewController(context: context)
    }
    
    @MainActor
    public func updateUIViewController(
        _ viewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType,
        context: Context
    ) {
        updateSwiftUIX_Hi.AppKitOrUIKitViewController(viewController, context: context)
    }
    
    @MainActor
    public static func dismantleUIViewController(
        _ viewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType,
        coordinator: Coordinator
    ) {
        dismantleSwiftUIX_Hi.AppKitOrUIKitViewController(viewController, coordinator: coordinator)
    }
}

extension SwiftUIX_Hi.AppKitOrUIKitViewControllerRepresentable where SwiftUIX_Hi.AppKitOrUIKitViewControllerType: _AppKitOrUIKitRepresented {
    @MainActor
    public func makeUIViewController(
        context: Context
    ) -> SwiftUIX_Hi.AppKitOrUIKitViewControllerType {
        makeSwiftUIX_Hi.AppKitOrUIKitViewController(context: context)
    }
    
    @MainActor
    public func updateUIViewController(
        _ viewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType,
        context: Context
    ) {
        viewController.representatableStateFlags.insert(.updateInProgress)
        
        updateSwiftUIX_Hi.AppKitOrUIKitViewController(viewController, context: context)
        
        viewController.representatableStateFlags.remove(.updateInProgress)
        
        if !viewController.representatableStateFlags.contains(.didUpdateAtLeastOnce) {
            viewController.representatableStateFlags.insert(.didUpdateAtLeastOnce)
        }
    }
    
    @MainActor
    public static func dismantleUIViewController(
        _ viewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType,
        coordinator: Coordinator
    ) {
        dismantleSwiftUIX_Hi.AppKitOrUIKitViewController(viewController, coordinator: coordinator)
        
        viewController.representatableStateFlags.insert(.dismantled)
    }
}

#elseif os(macOS)
extension NSViewRepresentableContext: _AppKitOrUIKitViewRepresentableContext {
    
}

extension SwiftUIX_Hi.AppKitOrUIKitViewRepresentable {
    public typealias Context = NSViewRepresentableContext<Self>
        
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    @MainActor
    public func sizeThatFits(
        _ proposal: ProposedViewSize,
        nsView: SwiftUIX_Hi.AppKitOrUIKitViewType,
        context: Context
    ) -> CGSize? {
        self.sizeThatFits(proposal, view: nsView, context: context)
    }
}

extension SwiftUIX_Hi.AppKitOrUIKitViewRepresentable {
    @MainActor
    public func makeNSView(context: Context) -> SwiftUIX_Hi.AppKitOrUIKitViewType {
        makeSwiftUIX_Hi.AppKitOrUIKitView(context: context)
    }
    
    @MainActor
    public func updateNSView(
        _ view: SwiftUIX_Hi.AppKitOrUIKitViewType, 
        context: Context
    ) {
        weak var _view = view
        
        guard let view = _view else {
            return
        }
        
        let represented = view as? _AppKitOrUIKitRepresented
        
        represented?.representatableStateFlags.insert(.updateInProgress)

        updateSwiftUIX_Hi.AppKitOrUIKitView(view, context: context)
        
        represented?.representatableStateFlags.remove(.updateInProgress)
        
        if let represented, !represented.representatableStateFlags.contains(.didUpdateAtLeastOnce) {
            represented.representatableStateFlags.insert(.didUpdateAtLeastOnce)
        }
    }
    
    @MainActor
    public static func dismantleNSView(
        _ view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        coordinator: Coordinator
    ) {
        let represented = view as? _AppKitOrUIKitRepresented
        
        dismantleSwiftUIX_Hi.AppKitOrUIKitView(view, coordinator: coordinator)
        
        represented?.representatableStateFlags.insert(.dismantled)
    }
}

extension SwiftUIX_Hi.AppKitOrUIKitViewRepresentable where SwiftUIX_Hi.AppKitOrUIKitViewType: _AppKitOrUIKitRepresented {
    @MainActor
    public func makeNSView(
        context: Context
    ) -> SwiftUIX_Hi.AppKitOrUIKitViewType {
        makeSwiftUIX_Hi.AppKitOrUIKitView(context: context)
    }
    
    @MainActor
    public func updateNSView(
        _ view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        context: Context
    ) {
        view.representatableStateFlags.insert(.updateInProgress)
        
        updateSwiftUIX_Hi.AppKitOrUIKitView(view, context: context)
        
        view.representatableStateFlags.remove(.updateInProgress)
        
        if !view.representatableStateFlags.contains(.didUpdateAtLeastOnce) {
            view.representatableStateFlags.insert(.didUpdateAtLeastOnce)
        }
    }

    @MainActor
    public static func dismantleNSView(
        _ view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        coordinator: Coordinator
    ) {
        dismantleSwiftUIX_Hi.AppKitOrUIKitView(view, coordinator: coordinator)
        
        view.representatableStateFlags.insert(.dismantled)
    }
}

extension SwiftUIX_Hi.AppKitOrUIKitViewControllerRepresentable {
    public typealias Context = NSViewControllerRepresentableContext<Self>
    
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    @MainActor
    public func sizeThatFits(
        _ proposal: ProposedViewSize,
        nsViewController: Self.NSViewControllerType,
        context: Self.Context
    ) -> CGSize? {
        self.sizeThatFits(
            proposal,
            viewController: nsViewController,
            context: context
        )
    }
}

extension SwiftUIX_Hi.AppKitOrUIKitViewControllerRepresentable {
    @MainActor
    public func makeNSViewController(
        context: Context
    ) -> SwiftUIX_Hi.AppKitOrUIKitViewControllerType {
        makeSwiftUIX_Hi.AppKitOrUIKitViewController(context: context)
    }
    
    @MainActor
    public func updateNSViewController(
        _ viewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType,
        context: Context
    ) {
        updateSwiftUIX_Hi.AppKitOrUIKitViewController(viewController, context: context)
    }
    
    @MainActor
    public static func dismantleNSViewController(
        _ viewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType,
        coordinator: Coordinator
    ) {
        dismantleSwiftUIX_Hi.AppKitOrUIKitViewController(viewController, coordinator: coordinator)
    }
}

extension SwiftUIX_Hi.AppKitOrUIKitViewControllerRepresentable where SwiftUIX_Hi.AppKitOrUIKitViewControllerType: _AppKitOrUIKitRepresented {
    @MainActor
    public func makeNSViewController(
        context: Context
    ) -> SwiftUIX_Hi.AppKitOrUIKitViewControllerType {
        makeSwiftUIX_Hi.AppKitOrUIKitViewController(context: context)
    }
    
    @MainActor
    public func updateNSViewController(
        _ viewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType,
        context: Context
    ) {
        viewController.representatableStateFlags.insert(.updateInProgress)

        updateSwiftUIX_Hi.AppKitOrUIKitViewController(viewController, context: context)
        
        viewController.representatableStateFlags.remove(.updateInProgress)
        
        if !viewController.representatableStateFlags.contains(.didUpdateAtLeastOnce) {
            viewController.representatableStateFlags.insert(.didUpdateAtLeastOnce)
        }
    }
    
    @MainActor
    public static func dismantleNSViewController(
        _ viewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType,
        coordinator: Coordinator
    ) {
        dismantleSwiftUIX_Hi.AppKitOrUIKitViewController(viewController, coordinator: coordinator)
        
        viewController.representatableStateFlags.insert(.dismantled)
    }
}
#endif

#if os(iOS) || os(macOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
extension SwiftUIX_Hi.AppKitOrUIKitViewRepresentable {
    @MainActor
    public static func dismantleSwiftUIX_Hi.AppKitOrUIKitView(
        _ view: SwiftUIX_Hi.AppKitOrUIKitViewType,
        coordinator: Coordinator
    ) {
        
    }
}

extension SwiftUIX_Hi.AppKitOrUIKitViewControllerRepresentable {
    @MainActor
    public static func dismantleSwiftUIX_Hi.AppKitOrUIKitViewController(
        _ view: SwiftUIX_Hi.AppKitOrUIKitViewControllerType,
        coordinator: Coordinator
    ) {
        
    }
}
#endif

// MARK: - Auxiliary

@_documentation(visibility: internal)
public struct _SwiftUIX_EditableSwiftUIX_Hi.AppKitOrUIKitViewRepresentableContext: _AppKitOrUIKitViewRepresentableContext {
    public var coordinator: Void = ()
    public var transaction: Transaction
    public var environment: EnvironmentValues
    
    public init(
        transaction: Transaction = .init(),
        environment: EnvironmentValues
    ) {
        self.transaction = transaction
        self.environment = environment
    }
    
    public init(_ context: some _AppKitOrUIKitViewRepresentableContext) {
        self.transaction = context.transaction
        self.environment = context.environment
    }
}

extension _AppKitOrUIKitViewRepresentableContext {
    public func _editable() -> _SwiftUIX_EditableSwiftUIX_Hi.AppKitOrUIKitViewRepresentableContext {
        .init(self)
    }
}
