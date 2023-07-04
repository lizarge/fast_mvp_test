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
        
        let downloadManager = DownloadManager()
        let diskStatus = DiskStatus()
        let regionManager = RegionManager()
        
        container.register(DownloadManager.self) { resolver in
            return downloadManager
        }
        
        container.register(DiskStatus.self) { resolver in
            return diskStatus
        }
        
        container.register(RegionManager.self) { resolver in
            return regionManager
        }
    }
    
    public static func resolve<Service>(_ serviceType: Service.Type) -> Service {
        return DependencyManager.container.resolve(serviceType)!
    }

}
