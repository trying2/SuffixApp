//
//  ServiceLocator.swift
//  SuiApp3
//
//  Created by Александр Вяткин on 03.10.2021.
//

import Foundation

class ServiceLocator {
    private var containServices: [String: AnyObject] = .init()
    
    func registerService<T: AnyObject>(service: T) {
        let key = "\(T.self)"
        if containServices[key] == nil {
            containServices[key] = service
        }
    }
    func getService<T: AnyObject>(serviceType: T.Type) -> T? {
        let key = "\(T.self)"
        return containServices[key] as? T
    }
}
