//
//  DependencyManager.swift
//  mapdownloader
//
//  Created by ankudinov aleksandr on 03.07.2023.
//

import Foundation
import Swinject

final class DependencyManager {
    
    static public let container = Container()
    
    static func BuldDependecy() {
        setupGeneral()
    }
    
    private static func setupGeneral(){
        container.register(DownloadManager.self) { resolver in
            return DownloadManager()
        }
    }
}
