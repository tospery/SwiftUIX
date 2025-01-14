//
// Copyright (c) Vatsal Manot
//

#if os(iOS) || os(macOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)

import SwiftUI

fileprivate struct SwiftUIX_Hi.AppKitOrUIKitViewControllerResolver: SwiftUIX_Hi.AppKitOrUIKitViewControllerRepresentable {
    class SwiftUIX_Hi.AppKitOrUIKitViewControllerType: SwiftUIX_Hi.AppKitOrUIKitViewController {
        var onInsertion: (SwiftUIX_Hi.AppKitOrUIKitViewController) -> Void = { _ in }
        var onAppear: (SwiftUIX_Hi.AppKitOrUIKitViewController) -> Void = { _ in }
        var onDisappear: (SwiftUIX_Hi.AppKitOrUIKitViewController) -> Void = { _ in }
        var onRemoval: (SwiftUIX_Hi.AppKitOrUIKitViewController) -> Void = { _ in }
        
        private weak var resolvedParent: SwiftUIX_Hi.AppKitOrUIKitViewController?
        
        private func resolveIfNecessary(withParent parent: SwiftUIX_Hi.AppKitOrUIKitViewController?) {
            guard let parent = parent, resolvedParent == nil else {
                return
            }
            
            resolvedParent = parent
            
            onInsertion(parent)
        }
        
        private func deresolveIfNecessary() {
            guard let parent = resolvedParent else {
                return
            }
            
            onRemoval(parent)
        }
        
        #if os(iOS) || os(tvOS)
        override func didMove(toParent parent: SwiftUIX_Hi.AppKitOrUIKitViewController?) {
            super.didMove(toParent: parent)
            
            if let parent = parent {
                resolveIfNecessary(withParent: parent)
            } else {
                deresolveIfNecessary()
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            #if targetEnvironment(macCatalyst)
            if resolvedParent == nil {
                resolveIfNecessary(withParent: view.superview?._nearestResponder(ofKind: UIViewController.self))
            }
            #endif

            resolvedParent.map(onAppear)
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            
            resolvedParent.map(onDisappear)
        }
        #elseif os(macOS)
        override func loadView() {
            self.view = NSView()
            
            resolveIfNecessary(withParent: parent)
        }
        
        override func viewWillAppear() {
            super.viewWillAppear()
            
            resolveIfNecessary(withParent: view.nearestResponder(ofKind: NSViewController.self)?.root)
        }
        
        override func viewDidAppear() {
            super.viewDidAppear()
            
            resolvedParent.map(onAppear)
        }
        
        override func viewWillDisappear() {
            super.viewWillDisappear()
            
            resolvedParent.map(onDisappear)
            
            deresolveIfNecessary()
        }
        #endif
        
        override func removeFromParent() {
            super.removeFromParent()
            
            deresolveIfNecessary()
        }
    }
    
    var onInsertion: (SwiftUIX_Hi.AppKitOrUIKitViewController) -> Void
    var onAppear: (SwiftUIX_Hi.AppKitOrUIKitViewController) -> Void
    var onDisappear: (SwiftUIX_Hi.AppKitOrUIKitViewController) -> Void
    var onRemoval: (SwiftUIX_Hi.AppKitOrUIKitViewController) -> Void
    
    func makeSwiftUIX_Hi.AppKitOrUIKitViewController(context: Context) -> SwiftUIX_Hi.AppKitOrUIKitViewControllerType {
        #if os(iOS) || os(tvOS) || os(visionOS)
        SwiftUIX_Hi.AppKitOrUIKitViewControllerType()
        #elseif os(macOS)
        SwiftUIX_Hi.AppKitOrUIKitViewControllerType(nibName: nil, bundle: nil)
        #endif
    }
    
    func updateSwiftUIX_Hi.AppKitOrUIKitViewController(_ viewController: SwiftUIX_Hi.AppKitOrUIKitViewControllerType, context: Context) {
        viewController.onInsertion = onInsertion
        viewController.onAppear = onAppear
        viewController.onDisappear = onDisappear
        viewController.onRemoval = onRemoval
    }
}

// MARK: - API

extension View {
    /// Resolve the nearest `UIViewController` or `NSViewController` in the view hierarchy.
    ///
    /// This usually tends to be SwiftUI's platform-specific adaptor.
    public func onSwiftUIX_Hi.AppKitOrUIKitViewControllerResolution(
        perform action: @escaping (SwiftUIX_Hi.AppKitOrUIKitViewController) -> ()
    ) -> some View {
        background(
            SwiftUIX_Hi.AppKitOrUIKitViewControllerResolver(
                onInsertion: action,
                onAppear: { _ in },
                onDisappear: { _ in },
                onRemoval: { _ in }
            )
            .allowsHitTesting(false)
            .accessibility(hidden: true)
        )
    }
    
    @_disfavoredOverload
    public func onSwiftUIX_Hi.AppKitOrUIKitViewControllerResolution(
        perform resolutionAction: @escaping (SwiftUIX_Hi.AppKitOrUIKitViewController) -> () = { _ in },
        onAppear: @escaping (SwiftUIX_Hi.AppKitOrUIKitViewController) -> () = { _ in },
        onDisappear: @escaping (SwiftUIX_Hi.AppKitOrUIKitViewController) -> () = { _ in },
        onRemoval deresolutionAction: @escaping (SwiftUIX_Hi.AppKitOrUIKitViewController) -> () = { _ in }
    ) -> some View {
        background(
            SwiftUIX_Hi.AppKitOrUIKitViewControllerResolver(
                onInsertion: resolutionAction,
                onAppear: onAppear,
                onDisappear: onDisappear,
                onRemoval: deresolutionAction
            )
            .allowsHitTesting(false)
            .accessibility(hidden: true)
        )
    }
}

#if os(iOS) ||  os(macOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
@MainActor
@ViewBuilder
public func withSwiftUIX_Hi.AppKitOrUIKitViewController<Content: View>(
    @ViewBuilder _ content: @escaping (SwiftUIX_Hi.AppKitOrUIKitViewController?) -> Content
) -> some View {
    if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
        _WithSwiftUIX_Hi.AppKitOrUIKitViewController(content: content)
    } else {
        withInlineState(initialValue: _SwiftUIX_ObservableWeakReferenceBox<SwiftUIX_Hi.AppKitOrUIKitViewController>(nil)) { viewControllerBox in
            withInlineObservedObject(viewControllerBox.wrappedValue) { box in
                content(box.value)
            }
            .onSwiftUIX_Hi.AppKitOrUIKitViewControllerResolution { viewController in
                if viewController !== viewControllerBox.wrappedValue.value {
                    viewControllerBox.wrappedValue.value = viewController
                }
            }
        }
    }
}
#endif

// MARK: - Auxiliary

#if os(macOS)
extension NSResponder {
    fileprivate func nearestResponder<Responder: NSResponder>(ofKind kind: Responder.Type) -> Responder? {
        guard !isKind(of: kind) else {
            return (self as! Responder)
        }
        
        return nextResponder?.nearestResponder(ofKind: kind)
    }
}

extension NSViewController {
    fileprivate var root: NSViewController {
        parent?.root ?? self
    }
}
#endif

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
private struct _WithSwiftUIX_Hi.AppKitOrUIKitViewController<Content: View>: View {
    let content: (SwiftUIX_Hi.AppKitOrUIKitViewController?) -> Content

    @StateObject private var appKitOrUIKitViewControllerBox = _SwiftUIX_ObservableWeakReferenceBox<SwiftUIX_Hi.AppKitOrUIKitViewController>(nil)

    var body: some View {
        content(appKitOrUIKitViewControllerBox.value)
            .onSwiftUIX_Hi.AppKitOrUIKitViewControllerResolution { viewController in
                if viewController !== appKitOrUIKitViewControllerBox.value {
                    DispatchQueue.main.async {
                        appKitOrUIKitViewControllerBox.value = viewController
                    }
                }
            }
    }
}

private struct _ResolveSwiftUIX_Hi.AppKitOrUIKitViewController: ViewModifier {
    @State var _appKitOrUIKitViewControllerBox = _SwiftUIX_ObservableWeakReferenceBox<SwiftUIX_Hi.AppKitOrUIKitViewController>(nil)
    @State var presentationCoordinatorBox = _SwiftUIX_ObservableWeakReferenceBox<CocoaPresentationCoordinator>(nil)

    init(_ appKitOrUIKitViewController: SwiftUIX_Hi.AppKitOrUIKitViewController?) {
        self._appKitOrUIKitViewControllerBox = .init(appKitOrUIKitViewController)
    }

    init() {

    }

    func body(content: Content) -> some View {
        PassthroughView {
            #if os(iOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
            content
                .modifier(ProvideNavigator(_appKitOrUIKitViewControllerBox: _appKitOrUIKitViewControllerBox))
            #elseif os(macOS)
            content
            #endif
        }
        .modifier(_UseCocoaPresentationCoordinator(coordinator: presentationCoordinatorBox))
        .environment(\._appKitOrUIKitViewControllerBox, _appKitOrUIKitViewControllerBox)
        .onSwiftUIX_Hi.AppKitOrUIKitViewControllerResolution { [weak _appKitOrUIKitViewControllerBox, weak presentationCoordinatorBox] viewController in
            guard let _appKitOrUIKitViewControllerBox = _appKitOrUIKitViewControllerBox, let presentationCoordinatorBox = presentationCoordinatorBox else {
                return
            }

            DispatchQueue.main.async {
                if !(_appKitOrUIKitViewControllerBox.value === viewController) {
                    _appKitOrUIKitViewControllerBox.value = viewController
                }

                if !(presentationCoordinatorBox.value === viewController._cocoaPresentationCoordinator) {
                    presentationCoordinatorBox.value =
                    viewController.presentationCoordinator
                }
            }
        }
        .background {
            ZeroSizeView()
                .id(_appKitOrUIKitViewControllerBox.value.map(ObjectIdentifier.init))
        }
    }

    #if os(iOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
    private struct ProvideNavigator: ViewModifier {
        struct Navigator: SwiftUIX.Navigator {
            weak var base: SwiftUIX_Hi.AppKitOrUIKitViewController?

            private var nearestNavigator: _UINavigationControllerNavigatorAdaptorBox? {
                base?.nearestNavigationController.map(_UINavigationControllerNavigatorAdaptorBox.init(navigationController:))
            }

            func push<V: View>(_ view: V, withAnimation animation: Animation?) {
                nearestNavigator?.push(view, withAnimation: animation)
            }

            func pop(withAnimation animation: Animation?) {
                nearestNavigator?.pop(withAnimation: animation)
            }

            func popToRoot(withAnimation animation: Animation?) {
                nearestNavigator?.popToRoot(withAnimation: animation)
            }
        }

        @ObservedObject var _appKitOrUIKitViewControllerBox: _SwiftUIX_ObservableWeakReferenceBox<SwiftUIX_Hi.AppKitOrUIKitViewController>

        func body(content: Content) -> some View {
            content.environment(\.navigator, Navigator(base: _appKitOrUIKitViewControllerBox.value))
        }
    }
    #endif
}

#endif

extension View {
    #if os(iOS) || os(macOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)
    public func _resolveSwiftUIX_Hi.AppKitOrUIKitViewController(
        with viewController: SwiftUIX_Hi.AppKitOrUIKitViewController?
    ) -> some View {
        modifier(_ResolveSwiftUIX_Hi.AppKitOrUIKitViewController(viewController))
    }
    #endif

    public func _resolveSwiftUIX_Hi.AppKitOrUIKitViewControllerIfAvailable() -> some View {
        #if os(iOS) || os(macOS) || os(tvOS) || targetEnvironment(macCatalyst)
        modifier(_ResolveSwiftUIX_Hi.AppKitOrUIKitViewController())
        #else
        self
        #endif
    }
}
