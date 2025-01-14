//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)

import UIKit

public typealias SwiftUIX_Hi.AppKitOrUIKitHostingView<Content: View> = UIHostingView<Content>

extension UIColor {
    @_disfavoredOverload
    public static var accentColor: UIColor? {
        UIColor(named: "AccentColor")
    }
}

extension UIEdgeInsets {
    var _SwiftUI_edgeInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

@_spi(Internal)
extension UIImage.Orientation {
    public init(_ orientation: CGImagePropertyOrientation) {
        switch orientation {
            case .up:
                self = .up
            case .upMirrored:
                self = .upMirrored
            case .down:
                self = .down
            case .downMirrored: 
                self = .downMirrored
            case .left:
                self = .left
            case .leftMirrored:
                self = .leftMirrored
            case .right:
                self = .right
            case .rightMirrored:
                self = .rightMirrored
        }
    }
}

extension UIUserInterfaceStyle {
    public init(from colorScheme: ColorScheme) {
        switch colorScheme {
            case .light:
                self = .light
            case .dark:
                self = .dark
            default:
                self = .unspecified
        }
    }
}

#endif

#if os(macOS)

import AppKit

public typealias SwiftUIX_Hi.AppKitOrUIKitGraphicsImageRenderer = NSGraphicsImageRenderer

extension NSEdgeInsets {
    public var _SwiftUI_edgeInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

extension NSImage.SymbolConfiguration {
    public convenience init(pointSize: CGFloat) {
        self.init(pointSize: pointSize, weight: .regular)
    }
}
extension NSSize {
    public init(_ edgeInsets: EdgeInsets) {
        self.init(
            width: edgeInsets.leading + edgeInsets.trailing,
            height: edgeInsets.top + edgeInsets.bottom
        )
    }
}

extension NSWindow {
    @objc open var isHidden: Bool {
        get {
            !isVisible
        } set {
            let isVisible = !newValue
            
            if self.isVisible != isVisible {
                self.setIsVisible(isVisible)
                
                if isVisible {
                    DispatchQueue.main.async {
                        #if os(macOS)
                        NotificationCenter.default.post(name: NSWindow.didBecomeVisibleNotification, object: self)
                        #endif
                    }
                }
            }
        }
    }
}

#endif

#if targetEnvironment(macCatalyst)

@objc public protocol NSAlertProtocol: NSObjectProtocol {
    @objc var alertStyle: UInt { get set }
    @objc var messageText: String { get set }
    @objc var informativeText: String { get set }
    
    @objc func addButton(withTitle: String)
    @objc func runModal()
    
    init()
}

@objc public protocol NSOpenPanelProtocol: NSObjectProtocol {
    @objc var directoryURL: URL? { get set }
    @objc var message: String? { get set }
    @objc var prompt: String? { get set }
    @objc var allowedFileTypes: [String]? { get set }
    @objc var allowsOtherFileTypes: Bool { get set }
    @objc var canChooseDirectories: Bool { get set }
    @objc var urls: [URL] { get set }
    
    @objc func runModal()
    
    init()
}

public let NSAlert_Type = unsafeBitCast(NSClassFromString("NSAlert"), to: NSAlertProtocol.Type.self)
public let NSOpenPanel_Type = unsafeBitCast(NSClassFromString("NSOpenPanel"), to: NSOpenPanelProtocol.Type.self)

extension NSWindow.Level {
    public static func + (lhs: Self, rhs: Int) -> Self {
        Self(rawValue: lhs.rawValue + rhs)
    }
    
    public static func + (lhs: Int, rhs: Self) -> Self {
        rhs + lhs
    }
}
#endif

#if os(iOS) || os(macOS) || os(tvOS) || os(visionOS) || targetEnvironment(macCatalyst)

private var _isAnimatingSwiftUIX_Hi.AppKitOrUIKit: Bool = false

public func _withSwiftUIX_Hi.AppKitOrUIKitAnimation(
    _ animation: _AppKitOrUIKitViewAnimation? = .default,
    @_implicitSelfCapture body: @escaping () -> ()
) {
    guard !_areAnimationsDisabledGlobally, !_isAnimatingSwiftUIX_Hi.AppKitOrUIKit, let animation else {
        body()
        
        return
    }
        
    _isAnimatingSwiftUIX_Hi.AppKitOrUIKit = true
    
    SwiftUIX_Hi.AppKitOrUIKitView.animate(
        withDuration: animation.duration ?? 0.3,
        delay: 0,
        options: animation.options ?? [],
        animations: body
    )
    
    _isAnimatingSwiftUIX_Hi.AppKitOrUIKit = false
}

#if os(iOS)
extension SwiftUIX_Hi.AppKitOrUIKitFontDescriptor.SymbolicTraits {
    public static let bold: Self = Self.traitBold
    public static let italic: Self = Self.traitItalic
}
#elseif os(macOS)
extension SwiftUIX_Hi.AppKitOrUIKitFontDescriptor.SymbolicTraits {
    public static let traitBold = Self.bold
    public static let traitItalic = Self.italic
}
#endif

extension SwiftUIX_Hi.AppKitOrUIKitViewController {
    public func _SwiftUIX_setNeedsLayout() {
        view._SwiftUIX_setNeedsLayout()
    }
    
    public func _SwiftUIX_layoutIfNeeded() {
        view._SwiftUIX_layoutIfNeeded()
    }
}

extension EnvironmentValues {
    struct SwiftUIX_Hi.AppKitOrUIKitViewControllerBoxKey: EnvironmentKey {
        typealias Value = _SwiftUIX_ObservableWeakReferenceBox<SwiftUIX_Hi.AppKitOrUIKitViewController>?
        
        static let defaultValue: Value = nil
    }
    
    var _appKitOrUIKitViewControllerBox: SwiftUIX_Hi.AppKitOrUIKitViewControllerBoxKey.Value {
        get {
            self[SwiftUIX_Hi.AppKitOrUIKitViewControllerBoxKey.self]
        } set {
            self[SwiftUIX_Hi.AppKitOrUIKitViewControllerBoxKey.self] = newValue
        }
    }
}

#endif
