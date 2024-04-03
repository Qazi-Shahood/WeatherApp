//
//  SessionManagerStore.swift
//  PhotoApp
//
//  Created by Muhammad Raza on 07/11/2022.
//

import Foundation

protocol SessionManager {
    func sessionManager(for baseUrl: BaseURL) -> URLSession
}

final class SessionManagerStore: SessionManager {
    private var sessionManagers: [AnyHashable: URLSession] = [:]
    
    func sessionManager(for baseUrl: BaseURL) -> URLSession {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        let key = baseUrl.host
        if let sessionManager = sessionManagers[key] {
            return sessionManager
        }
        
        let manager = URLSession(configuration: .default)
        sessionManagers[key] = manager
        
        return manager
    }
}
