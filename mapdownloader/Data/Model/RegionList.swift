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
    var url:URL
    
    init(name: String, map: YNBool? = nil, regions: [Region]? = nil) {
        self.name = name
        self.map = map
        self.regions = regions
        
        self.url = URL(string:
                        "\(self.name.replacingOccurrences(of:" ", with: "_").capitalized)\(Constants.fileNamePostfix)") ?? (NSURL() as URL)
    }
}
