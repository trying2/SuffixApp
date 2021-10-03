//
//  File.swift
//  
//
//  Created by Александр Вяткин on 09.09.2021.
//

import Foundation
import SwiftUI

public extension AnyTransition {
    public static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading).combined(with: .opacity)
        let removal = AnyTransition.scale.combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
