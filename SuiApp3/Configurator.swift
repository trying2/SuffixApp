//
//  Configurator.swift
//  SuiApp3
//
//  Created by Александр Вяткин on 03.10.2021.
//

import Foundation
import Networking

class Configurator {
    static let shared = Configurator()
    let serviceLocator = ServiceLocator()
    
    private init() {
        self.registerServices()
    }
    
    func registerServices() {
        serviceLocator.registerService(service: ArticlesAPI())
        serviceLocator.registerService(service: MoviesAPI())
    }
}
