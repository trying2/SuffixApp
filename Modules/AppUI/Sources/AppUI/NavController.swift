//
//  File.swift
//  
//
//  Created by Александр Вяткин on 09.09.2021.
//

import Foundation
import SwiftUI

// MARK: - Public UI API
public struct NavControllerView<Content>: View where Content: View {
    
    @ObservedObject private var viewModel: NavControllerViewModel
    
    private let transition: (push: AnyTransition, pop: AnyTransition)
    
    private let content: Content
    
    public init(transition: NavTransition, easing: Animation = .easeOut(duration: 0.33), @ViewBuilder content: @escaping () -> Content) {
        viewModel = NavControllerViewModel(easing: easing)
        self.content = content()
        
        switch transition {
        case .custom(let trans):
            self.transition = (trans, trans)
        case .none:
            self.transition = (.identity, .identity)
        }
    }
    
    public var body: some View {
        let isRoot = viewModel.currentScreen == nil
        return
            GeometryReader { geometry in
                ZStack {
                if isRoot {
                    self.content
                        .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
                        .environmentObject(viewModel)
                } else {
                    viewModel.currentScreen?.nextScreen
                        .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
                        .environmentObject(viewModel)
                        .swipeToBack(viewModel: viewModel, geometry: geometry)
                }
            }
            
        }
    }
}

public struct NavPushButton<Label, Destination>: View where Label: View, Destination: View {
    @EnvironmentObject private var viewModel: NavControllerViewModel
    
    private let destination:  Destination
    private let label: Label
    
    public init(destination: Destination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    public var body: some View {
        label.onTapGesture {
            viewModel.push(destination)
        }
    }
}

public struct NavPopButton<Label>: View where Label: View {
    @EnvironmentObject private var viewModel: NavControllerViewModel
    
    private let destination:  PopDestination
    private let label: Label
    
    public init(destination: PopDestination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    public var body: some View {
        label.onTapGesture {
            viewModel.pop(to: destination)
        }
    }
}

// MARK: - Private API
final class NavControllerViewModel: ObservableObject {
    
    // Animation
    
    private let easing: Animation
    var navigationType = NavType.push
    
    // Common Logic
    @Published fileprivate var currentScreen: Screen?
    
    private var screenStack = ScreenStack() {
        didSet {
            currentScreen = screenStack.top()
        }
    }
    
    init(easing: Animation) {
        self.easing = easing
    }
    
    // API
    func push<S: View>(_ screenView: S) {
        withAnimation(easing) {
            navigationType = .push
            let screen = Screen(id: UUID().uuidString, nextScreen: AnyView(screenView))
            screenStack.push(screen)
        }
        
    }
    func pop(to: PopDestination) {
        withAnimation(easing) {
            navigationType = .pop
            switch to {
            case .previous:
                screenStack.popToPrevious()
            case .root:
                screenStack.popToRoot()
            }
        }
    }
}

// MARK: - Enums
public enum PopDestination {
    case previous
    case root
}

public enum NavType {
    case push
    case pop
}
public enum NavTransition {
    case none
    case custom(AnyTransition)
}


// MARK: - Nav Stack Logic
private struct ScreenStack {
    private var screens: [Screen] = .init()
    
    func top() -> Screen? {
        screens.last
    }
    
    mutating func push(_ s: Screen) {
        screens.append(s)
    }
    mutating func popToPrevious() {
        _ = screens.popLast()
    }
    mutating func popToRoot() {
        screens.removeAll()
    }
}

struct Screen: Identifiable, Equatable {
    let id: String
    let nextScreen: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}

struct SwipeToBack: ViewModifier {
    @EnvironmentObject private var viewModel: NavControllerViewModel
    var onChanged: (() -> Void)?
    var geometry: GeometryProxy
    
    func body(content: Content) -> some View {
        content.gesture(DragGesture()
                            .onChanged { _ in
                                self.onChanged?()
                            }
                            .onEnded({ drag in
                                if -drag.predictedEndTranslation.width > self.geometry.size.width / 2 {
                                    // left
                                }
                                if drag.predictedEndTranslation.width > self.geometry.size.width / 2 {
                                    viewModel.pop(to: .previous)
                                }
                            }))
    }
}
extension View {
    func swipeToBack(viewModel: NavControllerViewModel, geometry: GeometryProxy, onChanged: (() -> Void)? = nil) -> some View {
        ModifiedContent(content: self, modifier: SwipeToBack(onChanged: onChanged, geometry: geometry))
            .environmentObject(viewModel)
    }
}
