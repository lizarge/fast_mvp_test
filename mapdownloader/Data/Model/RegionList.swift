//
//  Region.swift
//  mapdownloader
//
//  Created by ankudinov aleksandr on 03.07.2023.
//

import Foundation

struct Region: Codable  {
    
    enum YNBool:String, Codable {
        case yes
        case no
        
        var bool:Bool {
            return self == .yes
        }
    }
    
    var name: String
    var map: YNBool?
    
    var regions: [Region]?

    func generateDownloadTool() -> URL? {
        return nil
    }
}
