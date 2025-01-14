//
// Copyright (c) Vatsal Manot
//

import Swift

#if canImport(AppKit)

@_documentation(visibility: internal)
public enum SwiftUIX_Hi.AppKitOrUIKitBackgroundFetchResult {
    case newData
    case noData
    case failed
}

#elseif canImport(WatchKit)

@_documentation(visibility: internal)
public enum SwiftUIX_Hi.AppKitOrUIKitBackgroundFetchResult {
    case newData
    case noData
    case failed
}

#else

import UIKit

public typealias SwiftUIX_Hi.AppKitOrUIKitBackgroundFetchResult = UIBackgroundFetchResult

#endif
