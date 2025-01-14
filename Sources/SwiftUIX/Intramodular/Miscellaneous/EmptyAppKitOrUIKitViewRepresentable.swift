//
// Copyright (c) Vatsal Manot
//

import SwiftUI

@_documentation(visibility: internal)
public struct EmptySwiftUIX_Hi.AppKitOrUIKitViewRepresentable: View {
    private let update: (any _AppKitOrUIKitViewRepresentableContext) -> Void
    private let dismantle: () -> Void
    
    public init(
        update: @escaping (any _AppKitOrUIKitViewRepresentableContext) -> Void,
        dismantle: @escaping () -> Void = { }
    ) {
        self.update = update
        self.dismantle = dismantle
    }
    
    public var body: some View {
        Guts(update: update, dismantle: dismantle)
            .frame(width: 0, height: 0)
            .opacity(0)
            .accessibility(hidden: true)
    }
}

#if os(macOS) || os(iOS) || os(tvOS) || os(visionOS)
extension EmptySwiftUIX_Hi.AppKitOrUIKitViewRepresentable {
    private struct Guts: SwiftUIX_Hi.AppKitOrUIKitViewRepresentable {
        public typealias SwiftUIX_Hi.AppKitOrUIKitViewType = SwiftUIX_Hi.AppKitOrUIKitView
        
        private let update: (any _AppKitOrUIKitViewRepresentableContext) -> Void
        private let dismantle: () -> Void
        
        init(
            update: @escaping (any _AppKitOrUIKitViewRepresentableContext) -> Void,
            dismantle: @escaping () -> Void = { }
        ) {
            self.update = update
            self.dismantle = dismantle
        }
        
        public func makeSwiftUIX_Hi.AppKitOrUIKitView(context: Context) -> SwiftUIX_Hi.AppKitOrUIKitViewType {
            SwiftUIX_Hi.AppKitOrUIKitViewType()
        }
        
        public func updateSwiftUIX_Hi.AppKitOrUIKitView(
            _ view: SwiftUIX_Hi.AppKitOrUIKitViewType,
            context: Context
        ) {
            DispatchQueue.main.async {
                update(context)
            }
        }
        
        /*public static func dismantleSwiftUIX_Hi.AppKitOrUIKitView(
         _ view: Self,
         coordinator: Coordinator
         ) {
         DispatchQueue.main.async {
         view.dismantle()
         }
         }*/
    }
}
#elseif os(watchOS)
extension EmptySwiftUIX_Hi.AppKitOrUIKitViewRepresentable {
    private struct Guts: View {
        private let update: (any _AppKitOrUIKitViewRepresentableContext) -> Void
        private let dismantle: () -> Void
        
        init(
            update: @escaping (any _AppKitOrUIKitViewRepresentableContext) -> Void,
            dismantle: @escaping () -> Void = { }
        ) {
            self.update = update
            self.dismantle = dismantle
        }
        
        public var body: some View {
            ZeroSizeView() // FIXME
        }
    }
}
#endif
