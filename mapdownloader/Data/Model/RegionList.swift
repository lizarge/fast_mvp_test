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
        
        init(value:String?){
            if let value = value, value == "no" {
                self.init(rawValue: "no")!
            } else {
                self.init(rawValue: "yes")!
            }
        }
        
        var bool:Bool {
            return self == .yes
        }
    }
    
    var name: String
    var downloadPrefix: String?
    var map: YNBool?
    var regions: [Region]?
    var url:URL
    
    init(name: String, map: YNBool? = nil, regions: [Region]? = nil) {
        self.name = name
        self.map = map
        self.regions = regions
        
        let capitalizedName = self.name.lowercased().capitalizedSentence.replacingOccurrences(of:" ", with: "_")
        
        self.url = URL(string: "\(capitalizedName)" ) ?? (NSURL() as URL)
    }
}


